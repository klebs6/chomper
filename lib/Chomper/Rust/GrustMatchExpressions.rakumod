unit module Chomper::Rust::GrustMatchExpressions;

use Data::Dump::Tree;

class MatchExpression is export {
    has $.scrutinee;
    has @.inner-attributes;
    has $.maybe-match-arms;

    has $.text;

    method gist {

        my $builder = "match " ~ $.scrutinee.gist ~ " ";

        $builder ~= "\{\n";

        for @.inner-attributes {
            $builder ~= $_.gist ~ "\n";
        }

        if $.maybe-match-arms {
            $builder ~= $.maybe-match-arms.gist.indent(4);
        }

        $builder ~= "\n\}";

        $builder
    }
}

class Scrutinee is export {
    has $.expression-nostruct;

    has $.text;

    method gist {
        $.expression-nostruct.gist
    }
}

class MatchArms is export {
    has @.items;
    has $.maybe-comment;

    has $.text;

    method gist {

        my $builder = @.items>>.gist.join("\n");

        if $.maybe-comment {
            $builder ~= $.maybe-comment.gist;
        }

        $builder
    }
}

class MatchArmsInnerItemWithBlock is export {
    has $.maybe-comment;
    has $.match-arm;
    has $.expression-with-block;

    has $.text;

    method gist {

        my $builder = "";

        if $.maybe-comment {
            $builder ~= $.maybe-comment.gist ~ "\n";
        }

        $builder ~= $.match-arm.gist;
        $builder ~= " => " ~ $.expression-with-block.gist;

        $builder
    }
}

class MatchArmsInnerItemWithoutBlock is export {
    has $.maybe-comment;
    has $.match-arm;
    has $.expression-noblock;

    has $.text;

    method gist {
        my $builder = "";

        if $.maybe-comment {
            $builder ~= $.maybe-comment.gist ~ "\n";
        }

        $builder ~= $.match-arm.gist;
        $builder ~= " => " ~ $.expression-noblock.gist ~ ",";

        $builder
    }
}

class MatchArmsOuterItem is export {
    has $.maybe-comment;
    has $.match-arm;
    has $.expression;

    has $.text;

    method gist {

        my $builder = "";

        if $.maybe-comment {
            $builder ~= $.maybe-comment.gist ~ "\n";
        }

        $builder ~= $.match-arm.gist ~ " => ";
        $builder ~= $.expression.gist;

        $builder
    }
}

class MatchArm is export {
    has @.outer-attributes;
    has $.pattern;
    has $.maybe-match-arm-guard;

    has $.text;

    method gist {

        my $builder = "";

        for @.outer-attributes {
            $builder ~= $_.gist ~ "\n";
        }

        $builder ~= $.pattern.gist ~ " ";

        if $.maybe-match-arm-guard {
            $builder ~= $_.gist;
        }

        $builder
    }
}

class MatchArmGuard is export {
    has $.expression;

    has $.text;

    method gist {
        "if " ~ $.expression.gist
    }
}

package MatchExpresisonGrammar is export {

    our role Rules {

        rule match-expression {
            <kw-match> 
            <scrutinee> 
            <tok-lbrace>
            <inner-attribute>*
            <match-arms>?
            <tok-rbrace>
        }

        rule scrutinee {
            <expression-nostruct>
        }

        rule scrutinee-except-lazy-boolean-operator-expression {
            <scrutinee> <?{$0 !~~ <binary-oror-expression>}>
        }

        #------------------
        rule match-arms {
            <match-arms-inner-item>*
            <match-arms-outer-item>
            <comment>?
        }

        proto rule match-arms-inner-item { * }

        rule match-arms-inner-item:sym<with-block> {  
            <comment>?
            <match-arm>
            <tok-fat-rarrow>
            <expression-with-block>
            <tok-comma>?
        }

        rule match-arms-inner-item:sym<without-block> {  
            <comment>?
            <match-arm> 
            <tok-fat-rarrow> 
            <expression-noblock> 
            <tok-comma>
        }

        proto rule expression-variant { * }
        rule expression-variant:sym<with>    { <expression-with-block> }
        rule expression-variant:sym<without> { <expression-noblock> }

        rule match-arms-outer-item {
            <comment>?
            <match-arm> 
            <tok-fat-rarrow> 
            <expression-variant>
            <tok-comma>?
        }

        rule match-arm {
            <outer-attribute>*
            <pattern>
            <match-arm-guard>?
        }

        rule match-arm-guard {
            <kw-if> <expression>
        }
    }

    our role Actions {

        method match-expression($/) {
            make MatchExpression.new(
                scrutinee        => $<scrutinee>.made,
                inner-attributes => $<inner-attribute>>>.made,
                maybe-match-arms => $<match-arms>.made,
                text             => $/.Str,
            )
        }

        method scrutinee($/) {
            make Scrutinee.new(
                expression-nostruct => $<expression-nostruct>.made,
                text                => $/.Str,
            )
        }

        method scrutinee-except-lazy-boolean-operator-expression($/) {
            make $<scrutinee>.made
        }

        #------------------
        method match-arms($/) {
            my @items = [
                |$<match-arms-inner-item>>>.made, 
                $<match-arms-outer-item>.made
            ];
            make MatchArms.new(
                items => @items,
                maybe-comment => $<comment>.made,
                text       => $/.Str,
            )
        }

        method match-arms-inner-item:sym<with-block>($/) {  
            make MatchArmsInnerItemWithBlock.new(
                maybe-comment         => $<comment>.made,
                match-arm             => $<match-arm>.made,
                expression-with-block => $<expression-with-block>.made,
                text                  => $/.Str,
            )
        }

        method match-arms-inner-item:sym<without-block>($/) {  
            make MatchArmsInnerItemWithoutBlock.new(
                maybe-comment      => $<comment>.made,
                match-arm          => $<match-arm>.made,
                expression-noblock => $<expression-noblock>.made,
                text               => $/.Str,
            )
        }

        method expression-variant:sym<with>($/)    { make $<expression-with-block>.made }
        method expression-variant:sym<without>($/) { make $<expression-noblock>.made }

        method match-arms-outer-item($/) {
            make MatchArmsOuterItem.new(
                maybe-comment => $<comment>.made,
                match-arm     => $<match-arm>.made,
                expression    => $<expression-variant>.made,
                text          => $/.Str,
            )
        }

        method match-arm($/) {
            make MatchArm.new(
                outer-attributes      => $<outer-attribute>>>.made,
                pattern               => $<pattern>.made,
                maybe-match-arm-guard => $<match-arm-guard>.made,
                text                  => $/.Str,
            )
        }

        method match-arm-guard($/) {
            make MatchArmGuard.new(
                expression => $<expression>.made,
                text       => $/.Str,
            )
        }
    }
}

unit module Chomper::Rust::GrustGenericArgs;

use Data::Dump::Tree;

class GenericArgConstGeneric is export {
    has $.identifier;
    has $.type;
    has $.maybe-default;

    method gist {

        my $builder 
        = "const " ~ $.identifier.gist ~ ": " ~ $.type.gist;

        if $.maybe-default {
            $builder ~= $.maybe-default.gist;
        }

        $builder
    }
}

class GenericArgs is export {

    has @.args;

    method gist {
        "<" ~ @.args>>.gist.join(",") ~ ">"
    }
}

class TraitBound is export {
    has Bool $.qmark;
    has $.maybe-for-lifetimes;
    has $.type-path;

    has $.text;

    method gist {

        my $builder = "";

        if $.qmark {
            $builder ~= "?";
        }

        if $.maybe-for-lifetimes {
            $builder ~= $.maybe-for-lifetimes.gist ~ " ";
        }

        $builder ~= $.type-path.gist;

        $builder
    }
}

class MinusLiteralExpression is export {
    has $.literal-expression;

    has $.text;

    method gist {
        "-" ~ $.literal-expression.gist
    }
}

class GenericArgsBinding is export {
    has $.identifier;
    has $.type;

    has $.text;

    method gist {
        $.identifier.gist ~ " = " ~ $.type.gist
    }
}

package GenericArgsGrammar is export {

    our role Rules {

        rule type-param-bounds {
            <type-param-bound>+ %% <tok-plus>
        }

        proto rule type-param-bound { * }
        rule type-param-bound:sym<lt> { <lifetime> }
        rule type-param-bound:sym<tb> { <trait-bound> }

        proto rule trait-bound { * }

        rule trait-bound:sym<no-parens> { 
            <tok-qmark>?
            <for-lifetimes>? 
            <type-path> 
        }

        rule trait-bound:sym<parens> { 
            <tok-lparen> 
            <tok-qmark>?
            <for-lifetimes>? 
            <type-path> 
            <tok-rparen> 
        }

        rule generic-args {
            <tok-lt>
            [ <generic-arg>* %% <tok-comma> ]
            <tok-gt>
        }

        rule generic-arg {  
            || <lifetime>
            || <generic-args-const-generic>
            || <generic-args-binding>
            || <type>
            || <generic-args-const>
        }

        proto rule generic-args-const                    { * }
        rule generic-args-const:sym<block>               { <block-expression> }
        rule generic-args-const:sym<lit>                 { <literal-expression> }
        rule generic-args-const:sym<minus-lit>           { <minus-literal-expression> }
        rule generic-args-const:sym<simple-path-segment> { <simple-path-segment> }

        rule generic-args-const-generic {  
            <kw-const> 
            <identifier> 
            <tok-colon> 
            <type> 
            [
                <tok-eq> 
                <literal-expression>
            ]?
        }

        rule minus-literal-expression {
            <tok-minus> <literal-expression>
        }

        rule generic-args-binding {
            <identifier> <tok-eq> <type>
        }
    }

    our role Actions {

        method type-param-bounds($/) {
            make $<type-param-bound>>>.made
        }

        method type-param-bound:sym<lt>($/) { make $<lifetime>.made }
        method type-param-bound:sym<tb>($/) { make $<trait-bound>.made }

        method trait-bound:sym<no-parens>($/) { 
            make TraitBound.new(
                qmark               => so $/<tok-qmark>:exists,
                maybe-for-lifetimes => $<for-lifetimes>.made,
                type-path           => $<type-path>.made,
                text                => $/.Str,
            )
        }

        method trait-bound:sym<parens>($/) { 
            make TraitBound.new(
                qmark               => so $/<tok-qmark>:exists,
                maybe-for-lifetimes => $<for-lifetimes>.made,
                type-path           => $<type-path>.made,
                text                => $/.Str,
            )
        }

        method generic-args($/) {
            make GenericArgs.new(
                args => $<generic-arg>>>.made
            )
        }

        method generic-arg($/) { 
            my $key = $/.keys[0];
            given $key {
                when "lifetime" {
                    make $<lifetime>.made 
                }
                when "generic-args-binding" {
                    make $<generic-args-binding>.made 
                }
                when "type" {
                    make $<type>.made 
                }
                when "generic-args-const" {
                    make $<generic-args-const>.made 
                }
                when "generic-args-const-generic" {
                    make $<generic-args-const-generic>.made 
                }
            }
        }

        method generic-args-const:sym<block>($/)               { make $<block-expression>.made }
        method generic-args-const:sym<lit>($/)                 { make $<literal-expression>.made }
        method generic-args-const:sym<minus-lit>($/)           { make $<minus-literal-expression>.made }
        method generic-args-const:sym<simple-path-segment>($/) { make $<simple-path-segment>.made }

        #-----------------------
        method generic-args-const-generic($/) { 
            make GenericArgConstGeneric.new(
                identifier    => $<identifier>.made,
                type          => $<type>.made,
                maybe-default => $<literal-expression>.made,
            )
        }

        method minus-literal-expression($/) {
            make MinusLiteralExpression.new(
                literal-expression => $<literal-expression>.made,
                text               => $/.Str,
            )
        }

        method generic-args-binding($/) {
            make GenericArgsBinding.new(
                identifier => $<identifier>.made,
                type       => $<type>.made,
                text       => $/.Str,
            )
        }
    }
}

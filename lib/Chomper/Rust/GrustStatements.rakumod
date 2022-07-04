unit module Chomper::Rust::GrustStatements;

use Data::Dump::Tree;

class Statements is export {
    has @.statements;
    has $.maybe-expression-noblock;

    has $.text;

    method gist {

        my @res = @.statements>>.gist;

        if $.maybe-expression-noblock {
            @res.push: $.maybe-expression-noblock.gist;
        }

        @res.join("\n\n")
    }
}

class LetStatement is export {
    has $.maybe-comment;
    has @.outer-attributes;
    has $.pattern-no-top-alt;
    has $.maybe-type;
    has $.maybe-expression;
    has $.maybe-line-comment;

    has $.text;

    method gist {

        my $builder = "";

        if $.maybe-comment {
            $builder ~= $.maybe-comment.gist ~ "\n";
        }

        for @.outer-attributes {
            $builder ~= $_.gist ~ "\n";
        }

        $builder ~= "let " ~ $.pattern-no-top-alt.gist;

        if $.maybe-type {
            $builder ~= ": " ~ $.maybe-type.gist;
        }

        if $.maybe-expression {
            $builder ~= " = " ~ $.maybe-expression.gist;
        }

        $builder ~= ";";

        if $.maybe-line-comment {
            $builder ~= " " ~ $.maybe-line-comment.gist;

        }

        $builder
    }
}

class CommentWrapped is export {
    has $.maybe-comment;
    has $.wrapped;
    has Bool $.chomp = False;

    has $.text;

    method gist {
        do if $.maybe-comment {

            if $.chomp {

                qq:to/END/.chomp
                {$.maybe-comment.gist} {$.wrapped.gist}
                END

            } else {
                qq:to/END/.chomp
                {$.maybe-comment.gist}
                {$.wrapped.gist}
                END
            }
        } else {
            qq:to/END/.chomp
            {$.wrapped.gist}
            END
        }
    }
}

class ExpressionStatementNoBlock is export {
    has $.maybe-comment;
    has $.expression-noblock;

    has $.text;

    method gist {
        do if $.maybe-comment {
            qq:to/END/.chomp
            {$.maybe-comment.gist}
            {$.expression-noblock.gist};
            END
        } else {
            qq:to/END/.chomp
            {$.expression-noblock.gist};
            END
        }
    }
}

class ExpressionStatementBlock is export {
    has $.maybe-comment;
    has $.expression-with-block;

    has $.text;

    method gist {
        if $.maybe-comment {
            qq:to/END/.chomp.trim
            {$.maybe-comment.gist}
            {$.expression-with-block.gist}
            END
        } else {
            qq:to/END/.chomp.trim
            {$.expression-with-block.gist}
            END
        }
    }
}

package StatementGrammar is export {

    our role Rules {

        rule statements {  
            <statement>*
            <expression-noblock>?
        }

        proto rule statement { * }

        rule statement:sym<semi>  { <tok-semi> }
        rule statement:sym<let>   { <let-statement> }
        rule statement:sym<expr>  { <expression-statement> }
        rule statement:sym<macro> { <macro-invocation> }
        rule statement:sym<item>  { <crate-item> }

        regex let-statement {
            <comment>?
            <.ws>
            <outer-attribute>*
            <.ws>
            <kw-let>
            <.ws>
            <pattern-no-top-alt>
            <.ws>
            [
                <tok-colon>
                <.ws>
                <type>
            ]?
            <.ws>
            [
                <tok-eq>
                <.ws>
                <expression>
            ]?
            <.ws>
            <tok-semi>
            <.ws>
            <line-comment>? 
        }

        proto rule expression-statement { * }

        rule expression-statement:sym<noblock> { <comment>? <expression-noblock> <tok-semi> }
        rule expression-statement:sym<block>   { <comment>? <expression-with-block> <tok-semi>? }
    }

    our role Actions {

        method statements($/) {  

            my @statements = $<statement>>>.made;
            my $expr       = $<expression-noblock>.made;

            make Statements.new(
                statements               => @statements,
                maybe-expression-noblock => $expr,
                text                     => $/.Str,
            )
        }

        method statement:sym<let>($/)   { make $<let-statement>.made }
        method statement:sym<expr>($/)  { make $<expression-statement>.made }
        method statement:sym<macro>($/) { make $<macro-invocation>.made }
        method statement:sym<item>($/)  { make $<crate-item>.made }

        method let-statement($/) {
            make LetStatement.new(
                maybe-comment      => $<comment>.made,
                outer-attributes   => $<outer-attribute>>>.made,
                pattern-no-top-alt => $<pattern-no-top-alt>.made,
                maybe-type         => $<type>.made,
                maybe-expression   => $<expression>.made,
                maybe-line-comment => $<line-comment>.made,
                text               => $/.Str,
            )
        }

        method expression-statement:sym<noblock>($/) { 

            make ExpressionStatementNoBlock.new(
                maybe-comment      => $<comment>.made,
                expression-noblock => $<expression-noblock>.made,
                text               => $/.Str,
            )
        }

        method expression-statement:sym<block>($/) { 
            make ExpressionStatementBlock.new(
                maybe-comment         => $<comment>.made,
                expression-with-block => $<expression-with-block>.made,
                text                  => $/.Str,
            )
        }
    }
}

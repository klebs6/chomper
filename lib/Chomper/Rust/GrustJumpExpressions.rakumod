unit module Chomper::Rust::GrustJumpExpressions;

use Data::Dump::Tree;

class ContinueExpression is export {
    has $.maybe-lifetime-or-label;

    has $.text;

    method gist {

        my $builder = "continue";

        if $.maybe-lifetime-or-label {
            $builder ~= " " ~ $.maybe-lifetime-or-label.gist;
        }

        $builder
    }
}

class BreakExpression is export {
    has $.maybe-lifetime-or-label;
    has $.maybe-expression;

    has $.text;

    method gist {

        my $builder = "break";

        if $.maybe-lifetime-or-label {
            $builder ~= " " ~ $.maybe-lifetime-or-label.gist;
        }

        if $.maybe-expression {
            $builder ~= " " ~ $.maybe-expression.gist;
        }

        $builder
    }
}

class ReturnExpression is export {
    has $.maybe-expression;

    has $.text;

    method gist {

        my $builder = "return";

        if $.maybe-expression {
            $builder ~= " " ~ $.maybe-expression.gist;
        }

        $builder
    }
}

package JumpExpressionGrammar is export {

    our role Rules {

        rule continue-expression {
            <kw-continue>
            <lifetime-or-label>?
        }

        rule break-expression {
            <kw-break> 
            <lifetime-or-label>?
            <expression>?
        }

        rule return-expression {
            <kw-return> <expression>? 
        }
    }

    our role Actions {

        method continue-expression($/) {
            make ContinueExpression.new(
                maybe-lifetime-or-label => $<lifetime-or-label>.made,
                text                    => $/.Str,
            )
        }

        method break-expression($/) {
            make BreakExpression.new(
                maybe-lifetime-or-label => $<lifetime-or-label>.made,
                maybe-expression        => $<expression>.made,
                text                    => $/.Str,
            )
        }

        method return-expression($/) {
            make ReturnExpression.new(
                maybe-expression => $<expression>.made,
                text             => $/.Str,
            )
        }
    }
}

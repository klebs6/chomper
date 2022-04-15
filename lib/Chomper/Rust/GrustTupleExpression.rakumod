unit module Chomper::Rust::GrustTupleExpression;

use Data::Dump::Tree;

class TupleExpression is export {
    has $.maybe-tuple-elements;

    has $.text;

    method gist {
        if $.maybe-tuple-elements {
            "(" ~ $.maybe-tuple-elements.gist ~ ")"
        } else {
            "()"
        }
    }
}

class TupleElements is export {
    has @.expressions;

    has $.text;

    method gist {
        @.expressions>>.gist.join(",")
    }
}

class TupleIndex is export {
    has $.value;

    method gist {
        $.value
    }
}
package TupleExpressionGrammar is export {

    our role Rules {

        rule tuple-elements {
            <expression>* %% <tok-comma>
        }

        rule tuple-expression {
            <tok-lparen> <tuple-elements>? <tok-rparen> 
        }

        token tuple-index { <integer-literal> }
    }

    our role Actions {

        method tuple-elements($/) {
            make TupleElements.new(
                expressions => $<expression>>>.made,
                text        => $/.Str,
            )
        }

        method tuple-expression($/) {
            make TupleExpression.new(
                maybe-tuple-elements => $<tuple-elements>.made,
                text                 => $/.Str,
            )
        }

        method tuple-index($/) {
            make TupleIndex.new(value => ~$/ )
        }
    }
}

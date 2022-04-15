unit module Chomper::Rust::GrustTupleExpression;

use Data::Dump::Tree;

our class TupleExpression {
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

our class TupleElements {
    has @.expressions;

    has $.text;

    method gist {
        @.expressions>>.gist.join(",")
    }
}

our class TupleIndex {
    has $.value;

    method gist {
        $.value
    }
}

our role TupleExpression::Rules {

    rule tuple-elements {
        <expression>* %% <tok-comma>
    }

    rule tuple-expression {
        <tok-lparen> <tuple-elements>? <tok-rparen> 
    }

    token tuple-index { <integer-literal> }
}

our role TupleExpression::Actions {
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
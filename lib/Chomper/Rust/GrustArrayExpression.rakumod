unit module Chomper::Rust::GrustArrayExpression;

use Data::Dump::Tree;

class ArrayExpression is export {

    has $.maybe-array-elements;

    has $.text;

    method gist {

        if $.maybe-array-elements {
            "[" ~ $.maybe-array-elements.gist ~ "]"
        } else {
            "[" ~ "]"
        }
    }
}

package ArrayElements is export {

    our class ItemWithQuantity {
        has $.expression;
        has $.quantifier;

        has $.text;

        method gist {
            $.expression.gist ~ "; " ~ $.quantifier.gist
        }
    }

    our class CommaSeparatedList {
        has @.expressions;

        has $.text;

        method gist {
            @.expressions>>.gist.join(", ")
        }
    }
}

package ArrayExpressionGrammar is export {

    our role Rules {

        proto rule array-elements { * }

        rule array-elements:sym<semi> {
            <maybe-commented-expression> <tok-semi> <maybe-commented-expression>
        }

        rule array-elements:sym<commas> {
            <maybe-commented-expression>+ %% <tok-comma>
        }

        rule array-expression {
            <tok-lbrack> <array-elements>? <tok-rbrack> 
        }
    }

    our role Actions is export { 

        method array-elements:sym<semi>($/) {
            make ArrayElements::ItemWithQuantity.new(
                expression => $<maybe-commented-expression>>>.made[0],
                quantifier => $<maybe-commented-expression>>>.made[1],
                text       => $/.Str,
            )
        }

        method array-elements:sym<commas>($/) {
            make ArrayElements::CommaSeparatedList.new(
                expressions => $<maybe-commented-expression>>>.made,
                text        => $/.Str,
            )
        }

        method array-expression($/) {
            make ArrayExpression.new(
                maybe-array-elements => $<array-elements>.made,
                text                 => $/.Str,
            )
        }
    }
}

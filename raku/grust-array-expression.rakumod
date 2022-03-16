use Data::Dump::Tree;

our class ArrayExpression {
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

our class ArrayElementsItemQuantity {
    has $.expression;
    has $.quantifier;

    has $.text;

    method gist {
        $.expression.gist ~ "; " ~ $.quantifier.gist
    }
}

our class ArrayElementsList {
    has @.expressions;

    has $.text;

    method gist {
        @.expressions>>.gist.join(", ")
    }
}

our role ArrayExpression::Rules {

    proto rule array-elements { * }

    rule array-elements:sym<semi> {
        <expression> <tok-semi> <expression>
    }

    rule array-elements:sym<commas> {
        <expression>+ %% <tok-comma>
    }

    rule array-expression {
        <tok-lbrack> <array-elements>? <tok-rbrack> 
    }
}

our role ArrayExpression::Actions { 

    method array-elements:sym<semi>($/) {
        make ArrayElementsItemQuantity.new(
            expression => $<expression>>>.made[0],
            quantifier => $<expression>>>.made[1],
            text       => $/.Str,
        )
    }

    method array-elements:sym<commas>($/) {
        make ArrayElementsList.new(
            expressions => $<expression>>>.made,
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

our role ArrayExpression::Rules {

    rule array-expression {
        <tok-lbrack> <array-elements>? <tok-rbrack>
    }

    proto rule array-elements { * }

    rule array-elements:sym<commas> {
        <expression>+ %% <tok-comma>
    }

    rule array-elements:sym<semi> {
        <expression> <tok-semi> <expression>
    }

    rule index-expression {
        <expression> <tok-lbrack> <expression> <tok-rbrack>
    }
}

our role ArrayExpression::Actions {

}

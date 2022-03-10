our role ArrayExpression::Rules {

    proto rule array-elements { * }

    rule array-elements:sym<commas> {
        <expression>+ %% <tok-comma>
    }

    rule array-elements:sym<semi> {
        <expression> <tok-semi> <expression>
    }

}

our role ArrayExpression::Actions {

}

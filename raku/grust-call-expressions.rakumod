our role CallExpression::Rules {

    rule call-params {
        <expression>+ %% <tok-comma>
    }

}

our role CallExpression::Actions {

}

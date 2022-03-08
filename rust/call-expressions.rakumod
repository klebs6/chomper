our role CallExpression::Rules {
    rule call-expression {
        <expression> 
        <tok-lparen>
        <call-params>?
        <tok-rparen>
    }

    rule call-params {
        <expression>+ %% <tok-comma>
    }

    rule method-call-expression {
        <expression>
        <tok-dot>
        <path-expr-segment>
        <tok-lparen>
        <call-params>?
        <tok-rparen>
    }
}

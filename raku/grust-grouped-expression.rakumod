our role GroupedExpression::Rules {

    rule grouped-expression {
        <tok-lparen>
        <expression>
        <tok-rparen>
    }
}

our role GroupedExpression::Actions {}

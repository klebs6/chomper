our role ReturnExpression::Rules {

    rule return-expression {
        <kw-return> <expression>?
    }

    token await-expression {
        <expression> <tok-dot> <kw-await>
    }
}

our role ReturnExpression::Actions {}

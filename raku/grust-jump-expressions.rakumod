our role JumpExpression::Rules {

    rule continue-expression {
        <kw-continue>
        <lifetime-or-label>?
    }

    rule break-expression {
        <kw-break> 
        <lifetime-or-label>?
        <expression>?
    }

    rule return-expression {
        <kw-return> <expression>? 
    }
}

our role JumpExpression::Actions {}

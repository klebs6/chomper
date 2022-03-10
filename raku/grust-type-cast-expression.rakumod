our role TypeCastExpression::Rules {

    rule type-cast-expression {
        <expression> <kw-as> <type-no-bounds>
    }
}

our role TypeCastExpression::Actions {}

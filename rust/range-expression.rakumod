our role RangeExpression::Rules {

    proto rule range-expression { * }
    rule range-expression:sym<basic>        { <range-expr> }
    rule range-expression:sym<from>         { <range-from-expr> }
    rule range-expression:sym<to>           { <range-to-expr> }
    rule range-expression:sym<full>         { <range-full-expr> }
    rule range-expression:sym<inclusive>    { <range-inclusive-expr> }
    rule range-expression:sym<to-inclusive> { <range-to-inclusive-expr> }

    rule range-expr {
        <expression> <tok-dotdot> <expression>
    }

    rule range-from-expr {
        <expression> <tok-dotdot>
    }

    rule range-to-expr {
        <tok-dotdot> <expression>
    }

    rule range-full {
        <tok-dotdot>
    }

    rule range-inclusive-expr {
        <expression> <tok-dotdoteq> <expression>
    }

    rule range-to-inclusive-expr {
        <tok-dotdoteq> <expression>
    }
}

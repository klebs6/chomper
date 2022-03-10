our role BlockExpression::Rules {

    rule block-expression {
        <tok-lbrace>
        <inner-attribute>*
        <statements>?
        <tok-rbrace>
    }

    proto rule statements { * }

    rule statements:sym<basic> {
        <statement>+
    }

    rule statements:sym<basic-with-final-expr> {
        <statement>+
        <expression-noblock>
    }

    rule statements:sym<just-final-expr> {
        <expression-noblock>
    }

    rule async-block-expression {
        <kw-async>
        <kw-move>?
        <block-expression>
    }

    rule unsafe-block-expression {
        <kw-unsafe>
        <block-expression>
    }
}

our role BlockExpression::Actions {

}

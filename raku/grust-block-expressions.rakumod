our role BlockExpression::Rules {

    rule block-expression {
        <tok-lbrace>
        <inner-attribute>*
        <statements>?
        <tok-rbrace>
    }

    rule statements {  
        :my $*NOBLOCK = False;
        :my $*NOSTRUCT = False;
        <statements-variant>
    }

    proto rule statements-variant { * }

    rule statements-variant:sym<basic> {
        <statement>+
    }

    rule statements-variant:sym<basic-with-final-expr> {
        <statement>+
        <expression-noblock>
    }

    rule statements-variant:sym<just-final-expr> {
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

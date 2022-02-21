our class InitExpr::G {

    proto rule maybe-init_expr { * }

    rule maybe-init_expr:sym<a> {
        '=' <expr>
    }

    rule maybe-init_expr:sym<b> {

    }
}

our class InitExpr::A {

    method maybe-init_expr:sym<a>($/) {
        make $<expr>.made
    }

    method maybe-init_expr:sym<b>($/) {
        MkNone<140530961453856>
    }
}


our class InitExpr::Rules {

    proto rule maybe-init_expr { * }

    rule maybe-init_expr:sym<a> {
        '=' <expr>
    }

    rule maybe-init_expr:sym<b> {

    }
}

our class InitExpr::Actions {

    method maybe-init_expr:sym<a>($/) {
        make $<expr>.made
    }

    method maybe-init_expr:sym<b>($/) {
        MkNone<140530961453856>
    }
}


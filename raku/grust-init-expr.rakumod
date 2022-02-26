our class InitExpr::Rules {

    rule maybe-init-expr {
        [ '=' <expr> ]?
    }
}

our class InitExpr::Actions {

    method maybe-init-expr($/) {
        make $<expr>.made
    }
}


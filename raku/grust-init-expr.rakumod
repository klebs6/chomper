use grust-model;

our role InitExpr::Rules {

    rule maybe-init-expr {
        [ '=' <expr> ]?
    }
}

our role InitExpr::Actions {

    method maybe-init-expr($/) {
        make InitExpr.new(
            expr => $<expr>.made,
            text => ~$/,
        )
    }
}

our class DeclLocal {
    has $.pat;
    has $.maybe_init_expr;
    has $.maybe_ty_ascription;
}

our class Let::Rules {

    rule let {
        <LET> <pat> <maybe-ty_ascription> <maybe-init_expr> ';'
    }
}

our class Let::Actions {

    method let($/) {
        make DeclLocal.new(
            pat                 =>  $<pat>.made,
            maybe-ty_ascription =>  $<maybe-ty_ascription>.made,
            maybe-init_expr     =>  $<maybe-init_expr>.made,
        )
    }
}


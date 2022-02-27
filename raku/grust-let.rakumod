use grust-model;


our role Let::Rules {

    rule let {
        <LET> 
        <pat> 
        <maybe-ty_ascription> 
        <maybe-init_expr> ';'
    }
}

our role Let::Actions {

    method let($/) {
        make DeclLocal.new(
            pat                 =>  $<pat>.made,
            maybe-ty_ascription =>  $<maybe-ty_ascription>.made,
            maybe-init_expr     =>  $<maybe-init_expr>.made,
        )
    }
}

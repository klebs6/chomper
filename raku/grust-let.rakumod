use grust-model;

our role Let::Rules {

    rule let {
        <let_> 
        <pat> 
        <maybe-ty-ascription> 
        <maybe-init-expr> ';'
    }
}

our role Let::Actions {

    method let($/) {
        make DeclLocal.new(
            pat                 =>  $<pat>.made,
            maybe-ty-ascription =>  $<maybe-ty-ascription>.made,
            maybe-init-expr     =>  $<maybe-init-expr>.made,
        )
    }
}

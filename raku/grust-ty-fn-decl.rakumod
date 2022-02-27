use grust-model;


our role TyFnDecl::Rules {

    rule ty-fn-decl {
        <generic-params> 
        <fn-anon-params> 
        <ret-ty>
    }
}

our role TyFnDecl::Actions {

    method ty-fn-decl($/) {
        make TyFnDecl.new(
            generic-params =>  $<generic-params>.made,
            fn-anon-params =>  $<fn-anon-params>.made,
            ret-ty         =>  $<ret-ty>.made,
        )
    }
}


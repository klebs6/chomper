our class TyFnDecl {
    has $.fn-anon-params;
    has $.ret-ty;
    has $.generic-params;
}

our class TyFnDecl::Rules {

    rule ty-fn-decl {
        <generic-params> 
        <fn-anon-params> 
        <ret-ty>
    }
}

our class TyFnDecl::Actions {

    method ty-fn-decl($/) {
        make TyFnDecl.new(
            generic-params =>  $<generic-params>.made,
            fn-anon-params =>  $<fn-anon-params>.made,
            ret-ty         =>  $<ret-ty>.made,
        )
    }
}


our class TyFnDecl {
    has $.fn_anon_params;
    has $.ret_ty;
    has $.generic_params;
}

our class TyFnDecl::Rules {

    rule ty-fn_decl {
        <generic-params> <fn-anon_params> <ret-ty>
    }
}

our class TyFnDecl::Actions {

    method ty-fn_decl($/) {
        make TyFnDecl.new(
            generic-params =>  $<generic-params>.made,
            fn-anon_params =>  $<fn-anon_params>.made,
            ret-ty         =>  $<ret-ty>.made,
        )
    }
}

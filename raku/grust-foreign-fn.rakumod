our class ForeignFn {
    has $.maybe_where_clause;
    has $.fn_decl_allow_variadic;
    has $.ident;
    has $.generic_params;
}

our class ForeignFn::Rules {

    rule item-foreign_fn {
        <FN> 
        <ident> 
        <generic-params> 
        <fn-decl_allow_variadic> 
        <maybe-where_clause> ';'
    }
}

our class ForeignFn::Actions {

    method item-foreign_fn($/) {
        make ForeignFn.new(
            ident                  =>  $<ident>.made,
            generic-params         =>  $<generic-params>.made,
            fn-decl_allow_variadic =>  $<fn-decl_allow_variadic>.made,
            maybe-where_clause     =>  $<maybe-where_clause>.made,
        )
    }
}


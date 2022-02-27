use grust-model;


our role ForeignFn::Rules {

    rule item-foreign_fn {
        <FN> 
        <ident> 
        <generic-params> 
        <fn-decl_allow_variadic> 
        <maybe-where_clause> ';'
    }
}

our role ForeignFn::Actions {

    method item-foreign_fn($/) {
        make ForeignFn.new(
            ident                  =>  $<ident>.made,
            generic-params         =>  $<generic-params>.made,
            fn-decl_allow_variadic =>  $<fn-decl_allow_variadic>.made,
            maybe-where_clause     =>  $<maybe-where_clause>.made,
        )
    }
}


use grust-model;

our role ForeignFn::Rules {

    rule item-foreign-fn {
        <kw-fn> 
        <ident> 
        <generic-params> 
        <fn-decl-allow-variadic> 
        <maybe-where-clause> ';'
    }
}

our role ForeignFn::Actions {

    method item-foreign-fn($/) {
        make ForeignFn.new(
            ident                  =>  $<ident>.made,
            generic-params         =>  $<generic-params>.made,
            fn-decl-allow-variadic =>  $<fn-decl-allow-variadic>.made,
            maybe-where-clause     =>  $<maybe-where-clause>.made,
        )
    }
}

our class ForeignFn {
    has $.maybe-where-clause;
    has $.fn-decl-allow-variadic;
    has $.ident;
    has $.generic-params;

    has $.text;

    submethod TWEAK {
        say self.gist;
    }

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

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
            text                   => ~$/,
        )
    }
}

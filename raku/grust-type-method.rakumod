use Data::Dump::Tree;


our class TypeMethod {
    has $.fn-decl-with-self-allow-anon-params;
    has $.maybe-abi;
    has $.maybe-outer-attrs;
    has $.maybe-where-clause;
    has $.generic-params;
    has $.maybe-unsafe;
    has $.ident;

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

our role TypeMethod::Rules {

    proto rule type-method { * }

    rule type-method:sym<a> {
        <maybe-outer-attrs> 
        <maybe-unsafe> 
        <kw-fn> 
        <ident> 
        <generic-params> 
        <fn-decl-with-self-allow-anon-params> 
        <maybe-where-clause> 
        ';'
    }

    rule type-method:sym<b> {
        <maybe-outer-attrs> 
        <kw-const> 
        <maybe-unsafe> 
        <kw-fn> 
        <ident> 
        <generic-params> 
        <fn-decl-with-self-allow-anon-params> 
        <maybe-where-clause> 
        ';'
    }

    rule type-method:sym<c> {
        <maybe-outer-attrs> 
        <maybe-unsafe> 
        <kw-extern> 
        <maybe-abi> 
        <kw-fn> 
        <ident> 
        <generic-params> 
        <fn-decl-with-self-allow-anon-params> 
        <maybe-where-clause> 
        ';'
    }
}

our role TypeMethod::Actions {

    method type-method:sym<a>($/) {
        make TypeMethod.new(
            maybe-outer-attrs                   =>  $<maybe-outer-attrs>.made,
            maybe-unsafe                        =>  $<maybe-unsafe>.made,
            ident                               =>  $<ident>.made,
            generic-params                      =>  $<generic-params>.made,
            fn-decl-with-self-allow-anon-params =>  $<fn-decl-with-self-allow-anon-params>.made,
            maybe-where-clause                  =>  $<maybe-where-clause>.made,
            text                                => ~$/,
        )
    }

    method type-method:sym<b>($/) {
        make TypeMethod.new(
            maybe-outer-attrs                   =>  $<maybe-outer-attrs>.made,
            maybe-unsafe                        =>  $<maybe-unsafe>.made,
            ident                               =>  $<ident>.made,
            generic-params                      =>  $<generic-params>.made,
            fn-decl-with-self-allow-anon-params =>  $<fn-decl-with-self-allow-anon-params>.made,
            maybe-where-clause                  =>  $<maybe-where-clause>.made,
            text                                => ~$/,
        )
    }

    method type-method:sym<c>($/) {
        make TypeMethod.new(
            maybe-outer-attrs                   =>  $<maybe-outer-attrs>.made,
            maybe-unsafe                        =>  $<maybe-unsafe>.made,
            maybe-abi                           =>  $<maybe-abi>.made,
            ident                               =>  $<ident>.made,
            generic-params                      =>  $<generic-params>.made,
            fn-decl-with-self-allow-anon-params =>  $<fn-decl-with-self-allow-anon-params>.made,
            maybe-where-clause                  =>  $<maybe-where-clause>.made,
            text                                => ~$/,
        )
    }
}

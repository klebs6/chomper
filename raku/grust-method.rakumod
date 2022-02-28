use grust-model;

our role Method::Rules {

    proto rule trait-method { * }

    rule trait-method:sym<a> {
        <type-method>
    }

    rule trait-method:sym<b> {
        <method>
    }

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

    proto rule method { * }

    rule method:sym<a> {
        <maybe-outer-attrs> 
        <maybe-unsafe> 
        <kw-fn> 
        <ident> 
        <generic-params> 
        <fn-decl-with-self-allow-anon-params> 
        <maybe-where-clause> 
        <inner-attrs-and-block>
    }

    rule method:sym<b> {
        <maybe-outer-attrs> 
        <kw-const> 
        <maybe-unsafe> 
        <kw-fn> 
        <ident> 
        <generic-params> 
        <fn-decl-with-self-allow-anon-params> 
        <maybe-where-clause> 
        <inner-attrs-and-block>
    }

    rule method:sym<c> {
        <maybe-outer-attrs> 
        <maybe-unsafe> 
        <kw-extern> 
        <maybe-abi> 
        <kw-fn> 
        <ident> 
        <generic-params> 
        <fn-decl-with-self-allow-anon-params> 
        <maybe-where-clause> 
        <inner-attrs-and-block>
    }

    proto rule impl-method { * }

    rule impl-method:sym<a> {
        <attrs-and-vis> 
        <maybe-default> 
        <maybe-unsafe> 
        <kw-fn> 
        <ident> 
        <generic-params> 
        <fn-decl-with-self> 
        <maybe-where-clause> 
        <inner-attrs-and-block>
    }

    rule impl-method:sym<b> {
        <attrs-and-vis> 
        <maybe-default> 
        <kw-const> 
        <maybe-unsafe> 
        <kw-fn> 
        <ident> 
        <generic-params> 
        <fn-decl-with-self> 
        <maybe-where-clause> 
        <inner-attrs-and-block>
    }

    rule impl-method:sym<c> {
        <attrs-and-vis> 
        <maybe-default> 
        <maybe-unsafe> 
        <kw-extern> 
        <maybe-abi> 
        <kw-fn> 
        <ident> 
        <generic-params> 
        <fn-decl-with-self> 
        <maybe-where-clause> 
        <inner-attrs-and-block>
    }
}

our role Method::Actions {

    method trait-method:sym<a>($/) {
        make Required.new(
            type-method =>  $<type-method>.made,
        )
    }

    method trait-method:sym<b>($/) {
        make Provided.new(
            method =>  $<method>.made,
        )
    }

    method type-method:sym<a>($/) {
        make TypeMethod.new(
            maybe-outer-attrs                   =>  $<maybe-outer-attrs>.made,
            maybe-unsafe                        =>  $<maybe-unsafe>.made,
            ident                               =>  $<ident>.made,
            generic-params                      =>  $<generic-params>.made,
            fn-decl-with-self-allow-anon-params =>  $<fn-decl-with-self-allow-anon-params>.made,
            maybe-where-clause                  =>  $<maybe-where-clause>.made,
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
        )
    }

    method method:sym<a>($/) {
        make Method.new(
            maybe-outer-attrs                   =>  $<maybe-outer-attrs>.made,
            maybe-unsafe                        =>  $<maybe-unsafe>.made,
            ident                               =>  $<ident>.made,
            generic-params                      =>  $<generic-params>.made,
            fn-decl-with-self-allow-anon-params =>  $<fn-decl-with-self-allow-anon-params>.made,
            maybe-where-clause                  =>  $<maybe-where-clause>.made,
            inner-attrs-and-block               =>  $<inner-attrs-and-block>.made,
        )
    }

    method method:sym<b>($/) {
        make Method.new(
            maybe-outer-attrs                   =>  $<maybe-outer-attrs>.made,
            maybe-unsafe                        =>  $<maybe-unsafe>.made,
            ident                               =>  $<ident>.made,
            generic-params                      =>  $<generic-params>.made,
            fn-decl-with-self-allow-anon-params =>  $<fn-decl-with-self-allow-anon-params>.made,
            maybe-where-clause                  =>  $<maybe-where-clause>.made,
            inner-attrs-and-block               =>  $<inner-attrs-and-block>.made,
        )
    }

    method method:sym<c>($/) {
        make Method.new(
            maybe-outer-attrs                   =>  $<maybe-outer-attrs>.made,
            maybe-unsafe                        =>  $<maybe-unsafe>.made,
            maybe-abi                           =>  $<maybe-abi>.made,
            ident                               =>  $<ident>.made,
            generic-params                      =>  $<generic-params>.made,
            fn-decl-with-self-allow-anon-params =>  $<fn-decl-with-self-allow-anon-params>.made,
            maybe-where-clause                  =>  $<maybe-where-clause>.made,
            inner-attrs-and-block               =>  $<inner-attrs-and-block>.made,
        )
    }

    method impl-method:sym<a>($/) {
        make Method.new(
            attrs-and-vis         =>  $<attrs-and-vis>.made,
            maybe-default         =>  $<maybe-default>.made,
            maybe-unsafe          =>  $<maybe-unsafe>.made,
            ident                 =>  $<ident>.made,
            generic-params        =>  $<generic-params>.made,
            fn-decl-with-self     =>  $<fn-decl-with-self>.made,
            maybe-where-clause    =>  $<maybe-where-clause>.made,
            inner-attrs-and-block =>  $<inner-attrs-and-block>.made,
        )
    }

    method impl-method:sym<b>($/) {
        make Method.new(
            attrs-and-vis         =>  $<attrs-and-vis>.made,
            maybe-default         =>  $<maybe-default>.made,
            maybe-unsafe          =>  $<maybe-unsafe>.made,
            ident                 =>  $<ident>.made,
            generic-params        =>  $<generic-params>.made,
            fn-decl-with-self     =>  $<fn-decl-with-self>.made,
            maybe-where-clause    =>  $<maybe-where-clause>.made,
            inner-attrs-and-block =>  $<inner-attrs-and-block>.made,
        )
    }

    method impl-method:sym<c>($/) {
        make Method.new(
            attrs-and-vis         =>  $<attrs-and-vis>.made,
            maybe-default         =>  $<maybe-default>.made,
            maybe-unsafe          =>  $<maybe-unsafe>.made,
            maybe-abi             =>  $<maybe-abi>.made,
            ident                 =>  $<ident>.made,
            generic-params        =>  $<generic-params>.made,
            fn-decl-with-self     =>  $<fn-decl-with-self>.made,
            maybe-where-clause    =>  $<maybe-where-clause>.made,
            inner-attrs-and-block =>  $<inner-attrs-and-block>.made,
        )
    }
}

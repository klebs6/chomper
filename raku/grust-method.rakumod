our class Method {
    has $.ident;
    has $.fn-decl-with-self;
    has $.maybe-outer-attrs;
    has $.maybe-abi;
    has $.generic-params;
    has $.maybe-where-clause;
    has $.attrs-and-vis;
    has $.fn-decl-with-self-allow-anon-params;
    has $.maybe-unsafe;
    has $.maybe-default;
    has $.inner-attrs-and-block;

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

our role Method::Rules {

    #-----------------------------
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

    #-----------------------------
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

    method method:sym<a>($/) {
        make Method.new(
            maybe-outer-attrs                   =>  $<maybe-outer-attrs>.made,
            maybe-unsafe                        =>  $<maybe-unsafe>.made,
            ident                               =>  $<ident>.made,
            generic-params                      =>  $<generic-params>.made,
            fn-decl-with-self-allow-anon-params =>  $<fn-decl-with-self-allow-anon-params>.made,
            maybe-where-clause                  =>  $<maybe-where-clause>.made,
            inner-attrs-and-block               =>  $<inner-attrs-and-block>.made,
            text                                => ~$/,
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
            text                                => ~$/,
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
            text                                => ~$/,
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
            text                  => ~$/,
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
            text                  => ~$/,
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
            text                  => ~$/,
        )
    }
}

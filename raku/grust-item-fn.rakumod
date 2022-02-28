use grust-model;

our role Fn::Rules {

    proto rule item-fn { * }

    rule item-fn:sym<a> {
        <kw-fn> 
        <ident> 
        <generic-params> 
        <fn-decl> 
        <maybe-where-clause> 
        <inner-attrs-and-block>
    }

    rule item-fn:sym<b> {
        <kw-const> 
        <kw-fn> 
        <ident> 
        <generic-params> 
        <fn-decl> 
        <maybe-where-clause> 
        <inner-attrs-and-block>
    }

    proto rule item-unsafe-fn { * }

    rule item-unsafe-fn:sym<a> {
        <kw-unsafe> 
        <kw-fn> 
        <ident> 
        <generic-params> 
        <fn-decl> 
        <maybe-where-clause> 
        <inner-attrs-and-block>
    }

    rule item-unsafe-fn:sym<b> {
        <kw-const> 
        <kw-unsafe> 
        <kw-fn> 
        <ident> 
        <generic-params> 
        <fn-decl> 
        <maybe-where-clause> 
        <inner-attrs-and-block>
    }

    rule item-unsafe-fn:sym<c> {
        <kw-unsafe> 
        <kw-extern> 
        <maybe-abi> 
        <kw-fn> 
        <ident> 
        <generic-params> 
        <fn-decl> 
        <maybe-where-clause> 
        <inner-attrs-and-block>
    }
}

our role Fn::Actions {

    method item-fn:sym<a>($/) {
        make ItemFn.new(
            ident                 =>  $<ident>.made,
            generic-params        =>  $<generic-params>.made,
            fn-decl               =>  $<fn-decl>.made,
            maybe-where-clause    =>  $<maybe-where-clause>.made,
            inner-attrs-and-block =>  $<inner-attrs-and-block>.made,
        )
    }

    method item-fn:sym<b>($/) {
        make ItemFn.new(
            ident                 =>  $<ident>.made,
            generic-params        =>  $<generic-params>.made,
            fn-decl               =>  $<fn-decl>.made,
            maybe-where-clause    =>  $<maybe-where-clause>.made,
            inner-attrs-and-block =>  $<inner-attrs-and-block>.made,
        )
    }

    method item-unsafe-fn:sym<a>($/) {
        make ItemUnsafeFn.new(
            ident                 =>  $<ident>.made,
            generic-params        =>  $<generic-params>.made,
            fn-decl               =>  $<fn-decl>.made,
            maybe-where-clause    =>  $<maybe-where-clause>.made,
            inner-attrs-and-block =>  $<inner-attrs-and-block>.made,
        )
    }

    method item-unsafe-fn:sym<b>($/) {
        make ItemUnsafeFn.new(
            ident                 =>  $<ident>.made,
            generic-params        =>  $<generic-params>.made,
            fn-decl               =>  $<fn-decl>.made,
            maybe-where-clause    =>  $<maybe-where-clause>.made,
            inner-attrs-and-block =>  $<inner-attrs-and-block>.made,
        )
    }

    method item-unsafe-fn:sym<c>($/) {
        make ItemUnsafeFn.new(
            maybe-abi             =>  $<maybe-abi>.made,
            ident                 =>  $<ident>.made,
            generic-params        =>  $<generic-params>.made,
            fn-decl               =>  $<fn-decl>.made,
            maybe-where-clause    =>  $<maybe-where-clause>.made,
            inner-attrs-and-block =>  $<inner-attrs-and-block>.made,
        )
    }
}

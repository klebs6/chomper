our class ItemFn {
    has $.fn_decl;
    has $.inner_attrs_and_block;
    has $.ident;
    has $.generic_params;
    has $.maybe_where_clause;
}

our class ItemUnsafeFn {
    has $.maybe_abi;
    has $.generic_params;
    has $.fn_decl;
    has $.ident;
    has $.maybe_where_clause;
    has $.inner_attrs_and_block;
}

our class ItemFn::G {

    proto rule item-fn { * }

    rule item-fn:sym<a> {
        <FN> <ident> <generic-params> <fn-decl> <maybe-where_clause> <inner-attrs_and_block>
    }

    rule item-fn:sym<b> {
        <CONST> <FN> <ident> <generic-params> <fn-decl> <maybe-where_clause> <inner-attrs_and_block>
    }

    proto rule item-unsafe_fn { * }

    rule item-unsafe_fn:sym<a> {
        <UNSAFE> <FN> <ident> <generic-params> <fn-decl> <maybe-where_clause> <inner-attrs_and_block>
    }

    rule item-unsafe_fn:sym<b> {
        <CONST> <UNSAFE> <FN> <ident> <generic-params> <fn-decl> <maybe-where_clause> <inner-attrs_and_block>
    }

    rule item-unsafe_fn:sym<c> {
        <UNSAFE> <EXTERN> <maybe-abi> <FN> <ident> <generic-params> <fn-decl> <maybe-where_clause> <inner-attrs_and_block>
    }
}

our class ItemFn::A {

    method item-fn:sym<a>($/) {
        make ItemFn.new(
            ident                 =>  $<ident>.made,
            generic-params        =>  $<generic-params>.made,
            fn-decl               =>  $<fn-decl>.made,
            maybe-where_clause    =>  $<maybe-where_clause>.made,
            inner-attrs_and_block =>  $<inner-attrs_and_block>.made,
        )
    }

    method item-fn:sym<b>($/) {
        make ItemFn.new(
            ident                 =>  $<ident>.made,
            generic-params        =>  $<generic-params>.made,
            fn-decl               =>  $<fn-decl>.made,
            maybe-where_clause    =>  $<maybe-where_clause>.made,
            inner-attrs_and_block =>  $<inner-attrs_and_block>.made,
        )
    }

    method item-unsafe_fn:sym<a>($/) {
        make ItemUnsafeFn.new(
            ident                 =>  $<ident>.made,
            generic-params        =>  $<generic-params>.made,
            fn-decl               =>  $<fn-decl>.made,
            maybe-where_clause    =>  $<maybe-where_clause>.made,
            inner-attrs_and_block =>  $<inner-attrs_and_block>.made,
        )
    }

    method item-unsafe_fn:sym<b>($/) {
        make ItemUnsafeFn.new(
            ident                 =>  $<ident>.made,
            generic-params        =>  $<generic-params>.made,
            fn-decl               =>  $<fn-decl>.made,
            maybe-where_clause    =>  $<maybe-where_clause>.made,
            inner-attrs_and_block =>  $<inner-attrs_and_block>.made,
        )
    }

    method item-unsafe_fn:sym<c>($/) {
        make ItemUnsafeFn.new(
            maybe-abi             =>  $<maybe-abi>.made,
            ident                 =>  $<ident>.made,
            generic-params        =>  $<generic-params>.made,
            fn-decl               =>  $<fn-decl>.made,
            maybe-where_clause    =>  $<maybe-where_clause>.made,
            inner-attrs_and_block =>  $<inner-attrs_and_block>.made,
        )
    }
}

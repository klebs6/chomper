our class Method {
    has $.ident;
    has $.fn_decl_with_self;
    has $.maybe_outer_attrs;
    has $.maybe_abi;
    has $.generic_params;
    has $.maybe_where_clause;
    has $.attrs_and_vis;
    has $.fn_decl_with_self_allow_anon_params;
    has $.maybe_unsafe;
    has $.maybe_default;
    has $.inner_attrs_and_block;
}

our class Provided {
    has $.method;
}

our class Required {
    has $.type_method;
}

our class TypeMethod {
    has $.fn_decl_with_self_allow_anon_params;
    has $.maybe_abi;
    has $.maybe_outer_attrs;
    has $.maybe_where_clause;
    has $.generic_params;
    has $.maybe_unsafe;
    has $.ident;
}

our class Method::G {

    proto rule trait-method { * }

    rule trait-method:sym<a> {
        <type-method>
    }

    rule trait-method:sym<b> {
        <method>
    }

    proto rule type-method { * }

    rule type-method:sym<a> {
        <maybe-outer_attrs> <maybe-unsafe> <FN> <ident> <generic-params> <fn-decl_with_self_allow_anon_params> <maybe-where_clause> ';'
    }

    rule type-method:sym<b> {
        <maybe-outer_attrs> <CONST> <maybe-unsafe> <FN> <ident> <generic-params> <fn-decl_with_self_allow_anon_params> <maybe-where_clause> ';'
    }

    rule type-method:sym<c> {
        <maybe-outer_attrs> <maybe-unsafe> <EXTERN> <maybe-abi> <FN> <ident> <generic-params> <fn-decl_with_self_allow_anon_params> <maybe-where_clause> ';'
    }

    proto rule method { * }

    rule method:sym<a> {
        <maybe-outer_attrs> <maybe-unsafe> <FN> <ident> <generic-params> <fn-decl_with_self_allow_anon_params> <maybe-where_clause> <inner-attrs_and_block>
    }

    rule method:sym<b> {
        <maybe-outer_attrs> <CONST> <maybe-unsafe> <FN> <ident> <generic-params> <fn-decl_with_self_allow_anon_params> <maybe-where_clause> <inner-attrs_and_block>
    }

    rule method:sym<c> {
        <maybe-outer_attrs> <maybe-unsafe> <EXTERN> <maybe-abi> <FN> <ident> <generic-params> <fn-decl_with_self_allow_anon_params> <maybe-where_clause> <inner-attrs_and_block>
    }

    proto rule impl-method { * }

    rule impl-method:sym<a> {
        <attrs-and_vis> <maybe-default> <maybe-unsafe> <FN> <ident> <generic-params> <fn-decl_with_self> <maybe-where_clause> <inner-attrs_and_block>
    }

    rule impl-method:sym<b> {
        <attrs-and_vis> <maybe-default> <CONST> <maybe-unsafe> <FN> <ident> <generic-params> <fn-decl_with_self> <maybe-where_clause> <inner-attrs_and_block>
    }

    rule impl-method:sym<c> {
        <attrs-and_vis> <maybe-default> <maybe-unsafe> <EXTERN> <maybe-abi> <FN> <ident> <generic-params> <fn-decl_with_self> <maybe-where_clause> <inner-attrs_and_block>
    }
}

our class Method::A {

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
            maybe-outer_attrs                   =>  $<maybe-outer_attrs>.made,
            maybe-unsafe                        =>  $<maybe-unsafe>.made,
            ident                               =>  $<ident>.made,
            generic-params                      =>  $<generic-params>.made,
            fn-decl_with_self_allow_anon_params =>  $<fn-decl_with_self_allow_anon_params>.made,
            maybe-where_clause                  =>  $<maybe-where_clause>.made,
        )
    }

    method type-method:sym<b>($/) {
        make TypeMethod.new(
            maybe-outer_attrs                   =>  $<maybe-outer_attrs>.made,
            maybe-unsafe                        =>  $<maybe-unsafe>.made,
            ident                               =>  $<ident>.made,
            generic-params                      =>  $<generic-params>.made,
            fn-decl_with_self_allow_anon_params =>  $<fn-decl_with_self_allow_anon_params>.made,
            maybe-where_clause                  =>  $<maybe-where_clause>.made,
        )
    }

    method type-method:sym<c>($/) {
        make TypeMethod.new(
            maybe-outer_attrs                   =>  $<maybe-outer_attrs>.made,
            maybe-unsafe                        =>  $<maybe-unsafe>.made,
            maybe-abi                           =>  $<maybe-abi>.made,
            ident                               =>  $<ident>.made,
            generic-params                      =>  $<generic-params>.made,
            fn-decl_with_self_allow_anon_params =>  $<fn-decl_with_self_allow_anon_params>.made,
            maybe-where_clause                  =>  $<maybe-where_clause>.made,
        )
    }

    method method:sym<a>($/) {
        make Method.new(
            maybe-outer_attrs                   =>  $<maybe-outer_attrs>.made,
            maybe-unsafe                        =>  $<maybe-unsafe>.made,
            ident                               =>  $<ident>.made,
            generic-params                      =>  $<generic-params>.made,
            fn-decl_with_self_allow_anon_params =>  $<fn-decl_with_self_allow_anon_params>.made,
            maybe-where_clause                  =>  $<maybe-where_clause>.made,
            inner-attrs_and_block               =>  $<inner-attrs_and_block>.made,
        )
    }

    method method:sym<b>($/) {
        make Method.new(
            maybe-outer_attrs                   =>  $<maybe-outer_attrs>.made,
            maybe-unsafe                        =>  $<maybe-unsafe>.made,
            ident                               =>  $<ident>.made,
            generic-params                      =>  $<generic-params>.made,
            fn-decl_with_self_allow_anon_params =>  $<fn-decl_with_self_allow_anon_params>.made,
            maybe-where_clause                  =>  $<maybe-where_clause>.made,
            inner-attrs_and_block               =>  $<inner-attrs_and_block>.made,
        )
    }

    method method:sym<c>($/) {
        make Method.new(
            maybe-outer_attrs                   =>  $<maybe-outer_attrs>.made,
            maybe-unsafe                        =>  $<maybe-unsafe>.made,
            maybe-abi                           =>  $<maybe-abi>.made,
            ident                               =>  $<ident>.made,
            generic-params                      =>  $<generic-params>.made,
            fn-decl_with_self_allow_anon_params =>  $<fn-decl_with_self_allow_anon_params>.made,
            maybe-where_clause                  =>  $<maybe-where_clause>.made,
            inner-attrs_and_block               =>  $<inner-attrs_and_block>.made,
        )
    }

    method impl-method:sym<a>($/) {
        make Method.new(
            attrs-and_vis         =>  $<attrs-and_vis>.made,
            maybe-default         =>  $<maybe-default>.made,
            maybe-unsafe          =>  $<maybe-unsafe>.made,
            ident                 =>  $<ident>.made,
            generic-params        =>  $<generic-params>.made,
            fn-decl_with_self     =>  $<fn-decl_with_self>.made,
            maybe-where_clause    =>  $<maybe-where_clause>.made,
            inner-attrs_and_block =>  $<inner-attrs_and_block>.made,
        )
    }

    method impl-method:sym<b>($/) {
        make Method.new(
            attrs-and_vis         =>  $<attrs-and_vis>.made,
            maybe-default         =>  $<maybe-default>.made,
            maybe-unsafe          =>  $<maybe-unsafe>.made,
            ident                 =>  $<ident>.made,
            generic-params        =>  $<generic-params>.made,
            fn-decl_with_self     =>  $<fn-decl_with_self>.made,
            maybe-where_clause    =>  $<maybe-where_clause>.made,
            inner-attrs_and_block =>  $<inner-attrs_and_block>.made,
        )
    }

    method impl-method:sym<c>($/) {
        make Method.new(
            attrs-and_vis         =>  $<attrs-and_vis>.made,
            maybe-default         =>  $<maybe-default>.made,
            maybe-unsafe          =>  $<maybe-unsafe>.made,
            maybe-abi             =>  $<maybe-abi>.made,
            ident                 =>  $<ident>.made,
            generic-params        =>  $<generic-params>.made,
            fn-decl_with_self     =>  $<fn-decl_with_self>.made,
            maybe-where_clause    =>  $<maybe-where_clause>.made,
            inner-attrs_and_block =>  $<inner-attrs_and_block>.made,
        )
    }
}

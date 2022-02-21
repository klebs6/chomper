our class ExprQualifiedPath {
    has $.ty_sum;
    has $.maybe_qpath_params;
    has $.generic_args;
    has $.maybe_as_trait_ref;
    has $.ident;
}

our class ExprQualifiedPath::G {

    proto rule expr-qualified_path { * }

    rule expr-qualified_path:sym<a> {
        '<' <ty-sum> <maybe-as_trait_ref> '>' <MOD-SEP> <ident> <maybe-qpath_params>
    }

    rule expr-qualified_path:sym<b> {
        <SHL> <ty-sum> <maybe-as_trait_ref> '>' <MOD-SEP> <ident> <maybe-as_trait_ref> '>' <MOD-SEP> <ident>
    }

    rule expr-qualified_path:sym<c> {
        <SHL> <ty-sum> <maybe-as_trait_ref> '>' <MOD-SEP> <ident> <generic-args> <maybe-as_trait_ref> '>' <MOD-SEP> <ident>
    }

    rule expr-qualified_path:sym<d> {
        <SHL> <ty-sum> <maybe-as_trait_ref> '>' <MOD-SEP> <ident> <maybe-as_trait_ref> '>' <MOD-SEP> <ident> <generic-args>
    }

    rule expr-qualified_path:sym<e> {
        <SHL> <ty-sum> <maybe-as_trait_ref> '>' <MOD-SEP> <ident> <generic-args> <maybe-as_trait_ref> '>' <MOD-SEP> <ident> <generic-args>
    }
}

our class ExprQualifiedPath::A {

    method expr-qualified_path:sym<a>($/) {
        make ExprQualifiedPath.new(
            ty-sum             =>  $<ty-sum>.made,
            maybe-as_trait_ref =>  $<maybe-as_trait_ref>.made,
            ident              =>  $<ident>.made,
            maybe-qpath_params =>  $<maybe-qpath_params>.made,
        )
    }

    method expr-qualified_path:sym<b>($/) {
        make ExprQualifiedPath.new(
            maybe-as_trait_ref =>  $<maybe-as_trait_ref>.made,
            ident              =>  $<ident>.made,
        )
    }

    method expr-qualified_path:sym<c>($/) {
        make ExprQualifiedPath.new(
            maybe-as_trait_ref =>  $<maybe-as_trait_ref>.made,
            ident              =>  $<ident>.made,
        )
    }

    method expr-qualified_path:sym<d>($/) {
        make ExprQualifiedPath.new(
            maybe-as_trait_ref =>  $<maybe-as_trait_ref>.made,
            ident              =>  $<ident>.made,
            generic-args       =>  $<generic-args>.made,
        )
    }

    method expr-qualified_path:sym<e>($/) {
        make ExprQualifiedPath.new(
            maybe-as_trait_ref =>  $<maybe-as_trait_ref>.made,
            ident              =>  $<ident>.made,
            generic-args       =>  $<generic-args>.made,
        )
    }
}

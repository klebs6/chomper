our class TyQualifiedPath::G {

    proto rule ty-qualified_path_and_generic_values { * }

    rule ty-qualified_path_and_generic_values:sym<a> {
        <ty-qualified_path> <maybe-bindings>
    }

    rule ty-qualified_path_and_generic_values:sym<b> {
        <ty-qualified_path> ',' <ty-sums> <maybe-bindings>
    }

    proto rule ty-qualified_path { * }

    rule ty-qualified_path:sym<a> {
        <ty-sum> <AS> <trait-ref> '>' <MOD-SEP> <ident>
    }

    rule ty-qualified_path:sym<b> {
        <ty-sum> <AS> <trait-ref> '>' <MOD-SEP> <ident> '+' <ty-param_bounds>
    }
}

our class TyQualifiedPath::A {

    method ty-qualified_path_and_generic_values:sym<a>($/) {
        make GenericValues.new(
            maybe-bindings =>  $<maybe-bindings>.made,
        )
    }

    method ty-qualified_path_and_generic_values:sym<b>($/) {
        make GenericValues.new(
            maybe-bindings =>  $<maybe-bindings>.made,
        )
    }

    method ty-qualified_path:sym<a>($/) {
        make TyQualifiedPath.new(
            ty-sum    =>  $<ty-sum>.made,
            trait-ref =>  $<trait-ref>.made,
            ident     =>  $<ident>.made,
        )
    }

    method ty-qualified_path:sym<b>($/) {
        make TyQualifiedPath.new(
            ty-sum    =>  $<ty-sum>.made,
            trait-ref =>  $<trait-ref>.made,
            ident     =>  $<ident>.made,
        )
    }
}

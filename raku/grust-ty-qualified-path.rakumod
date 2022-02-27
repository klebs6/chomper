our class TyQualifiedPath::Rules {

    proto rule ty-qualified-path-and-generic-values { * }

    rule ty-qualified-path-and-generic-values:sym<a> {
        <ty-qualified-path> <maybe-bindings>
    }

    rule ty-qualified-path-and-generic-values:sym<b> {
        <ty-qualified-path> ',' <ty-sums> <maybe-bindings>
    }

    proto rule ty-qualified-path { * }

    rule ty-qualified-path:sym<a> {
        <ty-sum> <AS> <trait-ref> '>' <MOD-SEP> <ident>
    }

    rule ty-qualified-path:sym<b> {
        <ty-sum> <AS> <trait-ref> '>' <MOD-SEP> <ident> '+' <ty-param-bounds>
    }
}

our class TyQualifiedPath::Actions {

    method ty-qualified-path-and-generic-values:sym<a>($/) {
        make GenericValues.new(
            maybe-bindings =>  $<maybe-bindings>.made,
        )
    }

    method ty-qualified-path-and-generic-values:sym<b>($/) {
        make GenericValues.new(
            maybe-bindings =>  $<maybe-bindings>.made,
        )
    }

    method ty-qualified-path:sym<a>($/) {
        make TyQualifiedPath.new(
            ty-sum    =>  $<ty-sum>.made,
            trait-ref =>  $<trait-ref>.made,
            ident     =>  $<ident>.made,
        )
    }

    method ty-qualified-path:sym<b>($/) {
        make TyQualifiedPath.new(
            ty-sum    =>  $<ty-sum>.made,
            trait-ref =>  $<trait-ref>.made,
            ident     =>  $<ident>.made,
        )
    }
}

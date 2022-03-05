use grust-model;

our role TyQualifiedPath::Rules {

    proto rule ty-qualified-path-and-generic-values { * }

    rule ty-qualified-path-and-generic-values:sym<a> {
        <ty-qualified-path> <maybe-bindings>
    }

    rule ty-qualified-path-and-generic-values:sym<b> {
        <ty-qualified-path> ',' <ty-sums> <maybe-bindings>
    }

    proto rule ty-qualified-path { * }

    rule ty-qualified-path:sym<a> {
        <ty-sum> <kw-as> <trait-ref> '>' <tok-mod-sep> <ident>
    }

    rule ty-qualified-path:sym<b> {
        <ty-sum> <kw-as> <trait-ref> '>' <tok-mod-sep> <ident> '+' <ty-param-bounds>
    }
}

our role TyQualifiedPath::Actions {

    method ty-qualified-path-and-generic-values:sym<a>($/) {
        make GenericValues.new(
            ty-qualified-path => $<ty-qualified-path>.made,
            maybe-bindings    => $<maybe-bindings>.made,
            text              => ~$/,
        )
    }

    method ty-qualified-path-and-generic-values:sym<b>($/) {
        make GenericValues.new(
            ty-qualified-path => $<ty-qualified-path>.made,
            ty-sums           =>  $<ty-sums>.made,
            maybe-bindings    =>  $<maybe-bindings>.made,
            text              => ~$/,
        )
    }

    method ty-qualified-path:sym<a>($/) {
        make TyQualifiedPath.new(
            ty-sum    =>  $<ty-sum>.made,
            trait-ref =>  $<trait-ref>.made,
            ident     =>  $<ident>.made,
            text      => ~$/,
        )
    }

    method ty-qualified-path:sym<b>($/) {
        make TyQualifiedPath.new(
            ty-sum          =>  $<ty-sum>.made,
            trait-ref       =>  $<trait-ref>.made,
            ident           =>  $<ident>.made,
            ty-param-bounds =>  $<ty-param-bounds>.made,
            text            => ~$/,
        )
    }
}

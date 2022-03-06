use Data::Dump::Tree;

our class TyQualifiedPath {
    has $.ty-sum;
    has $.trait-ref;
    has $.ident;
    has $.maybe-as-trait-ref;
    has $.ty-param-bounds;

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

our class GenericValues {
    has $.ty-qualified-path;
    has $.maybe-bindings;
    has $.maybe-ty-sums-and-or-bindings;

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

our role GenericArgs::Rules {

    proto rule generic-args { * }

    rule generic-args:sym<a> {
        '<' <generic-values> '>'
    }

    # If generic-args starts with "<<", the first
    # arg must be a TyQualifiedPath because that's
    # the only type that can start with
    # a '<'. This rule parses that as the first
    # ty-sum and then continues with the rest of
    # generic-values.
    rule generic-args:sym<b> {
        <tok-shl> <ty-qualified-path-and-generic-values> '>'
    }

    rule generic-values {
        <maybe-ty-sums-and-or-bindings>
    }
}

our role GenericArgs::Actions {

    method generic-args:sym<a>($/) {
        make $<generic-values>.made
    }

    method generic-args:sym<b>($/) {
        make $<ty-qualified-path-and-generic-values>.made
    }

    method generic-values($/) {
        make GenericValues.new(
            maybe-ty-sums-and-or-bindings =>  $<maybe-ty-sums-and-or-bindings>.made,
            text                          => ~$/,
        )
    }
}

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

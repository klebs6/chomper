our class GenericValues {
    has $.maybe_bindings;
    has $.maybe_ty_sums_and_or_bindings;
}

our class GenericArgs::G {

    proto rule generic-args { * }

    rule generic-args:sym<a> {
        '<' <generic-values> '>'
    }

    # If generic_args starts with "<<", the first
    # arg must be a TyQualifiedPath because that's
    # the only type that can start with
    # a '<'. This rule parses that as the first
    # ty_sum and then continues with the rest of
    # generic_values.
    rule generic-args:sym<b> {
        <SHL> <ty-qualified_path_and_generic_values> '>'
    }

    rule generic-values {
        <maybe-ty_sums_and_or_bindings>
    }
}

our class GenericArgs::A {

    method generic-args:sym<a>($/) {
        make $<generic_values>.made
    }

    method generic-args:sym<b>($/) {
        make $<ty_qualified_path_and_generic_values>.made
    }

    method generic-values($/) {
        make GenericValues.new(
            maybe-ty_sums_and_or_bindings =>  $<maybe-ty_sums_and_or_bindings>.made,
        )
    }
}

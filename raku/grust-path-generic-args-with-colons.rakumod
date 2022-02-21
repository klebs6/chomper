
#-------------------------------------
# A path with a lifetime and type parameters with
# double colons before the type parameters;
# e.g. `foo::bar::<'a>::Baz::<T>`
#
# These show up in expr context, in order to
# disambiguate from "less-than" expressions.
our class PathGenericArgsWithColons::G {

    proto rule path-generic_args_with_colons { * }

    rule path-generic_args_with_colons:sym<a> {
        <ident>
    }

    rule path-generic_args_with_colons:sym<b> {
        <SUPER>
    }

    rule path-generic_args_with_colons:sym<c> {
        <path-generic_args_with_colons> <MOD-SEP> <ident>
    }

    rule path-generic_args_with_colons:sym<d> {
        <path-generic_args_with_colons> <MOD-SEP> <SUPER>
    }

    rule path-generic_args_with_colons:sym<e> {
        <path-generic_args_with_colons> <MOD-SEP> <generic-args>
    }
}

our class PathGenericArgsWithColons::A {

    method path-generic_args_with_colons:sym<a>($/) {
        make components.new(
            ident =>  $<ident>.made,
        )
    }

    method path-generic_args_with_colons:sym<b>($/) {
        make Super.new
    }

    method path-generic_args_with_colons:sym<c>($/) {
        ExtNode<140425165463024>
    }

    method path-generic_args_with_colons:sym<d>($/) {
        ExtNode<140425165463064>
    }

    method path-generic_args_with_colons:sym<e>($/) {
        ExtNode<140425165463104>
    }
}

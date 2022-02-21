
#--------------------------
# A path with no type parameters;
# e.g. `foo::bar::Baz`
#
# These show up in 'use' view-items, because these
# are processed without respect to types.
our class ViewPath {
    has $.ident;
}

our class PathNoTypesAllowed::Rules {

    proto rule path-no_types_allowed { * }

    rule path-no_types_allowed:sym<a> {
        <ident>
    }

    rule path-no_types_allowed:sym<b> {
        <MOD-SEP> <ident>
    }

    rule path-no_types_allowed:sym<c> {
        <SELF>
    }

    rule path-no_types_allowed:sym<d> {
        <MOD-SEP> <SELF>
    }

    rule path-no_types_allowed:sym<e> {
        <SUPER>
    }

    rule path-no_types_allowed:sym<f> {
        <MOD-SEP> <SUPER>
    }

    rule path-no_types_allowed:sym<g> {
        <path-no_types_allowed> <MOD-SEP> <ident>
    }
}

our class PathNoTypesAllowed::Actions {

    method path-no_types_allowed:sym<a>($/) {
        make ViewPath.new(
            ident =>  $<ident>.made,
        )
    }

    method path-no_types_allowed:sym<b>($/) {
        make ViewPath.new(
            ident =>  $<ident>.made,
        )
    }

    method path-no_types_allowed:sym<c>($/) {
        make ViewPath.new(

        )
    }

    method path-no_types_allowed:sym<d>($/) {
        make ViewPath.new(

        )
    }

    method path-no_types_allowed:sym<e>($/) {
        make ViewPath.new(

        )
    }

    method path-no_types_allowed:sym<f>($/) {
        make ViewPath.new(

        )
    }

    method path-no_types_allowed:sym<g>($/) {
        ExtNode<140417223175656>
    }
}

#--------------------------
# A path with a lifetime and type parameters, with
# no double colons before the type parameters;
# e.g. `foo::bar<'a>::Baz<T>`
#
# These show up in "trait references", the
# components of type-parameter bounds lists, as
# well as in the prefix of the
# path_generic_args_and_bounds rule, which is the
# full form of a named typed expression.
#
# They do not have (nor need) an extra '::' before
# '<' because unlike in expr context, there are no
# "less-than" type exprs to be ambiguous with.
our class Components {
    has $.maybe_ty_sums;
    has $.generic_args;
    has $.ident;
}

our class PathNoTypesAllowed::Rules {

    proto rule path-generic_args_without_colons { * }

    rule path-generic_args_without_colons:sym<a> {
        {self.set-prec(IDENT)} <ident>
    }

    rule path-generic_args_without_colons:sym<b> {
        {self.set-prec(IDENT)} <ident> <generic-args>
    }

    rule path-generic_args_without_colons:sym<c> {
        {self.set-prec(IDENT)} <ident> '(' <maybe-ty_sums> ')' <ret-ty>
    }

    rule path-generic_args_without_colons:sym<d> {
        {self.set-prec(IDENT)} <path-generic_args_without_colons> <MOD-SEP> <ident>
    }

    rule path-generic_args_without_colons:sym<e> {
        {self.set-prec(IDENT)} <path-generic_args_without_colons> <MOD-SEP> <ident> <generic-args>
    }

    rule path-generic_args_without_colons:sym<f> {
        {self.set-prec(IDENT)} <path-generic_args_without_colons> <MOD-SEP> <ident> '(' <maybe-ty_sums> ')' <ret-ty>
    }
}

our class PathNoTypesAllowed::Actions {

    method path-generic_args_without_colons:sym<a>($/) {
        make components.new(
            ident =>  $<ident>.made,
        )
    }

    method path-generic_args_without_colons:sym<b>($/) {
        make components.new(
            ident        =>  $<ident>.made,
            generic-args =>  $<generic-args>.made,
        )
    }

    method path-generic_args_without_colons:sym<c>($/) {
        make components.new(
            ident         =>  $<ident>.made,
            maybe-ty_sums =>  $<maybe-ty_sums>.made,
        )
    }

    method path-generic_args_without_colons:sym<d>($/) {
        ExtNode<140204309020904>
    }

    method path-generic_args_without_colons:sym<e>($/) {
        ExtNode<140204309020944>
    }

    method path-generic_args_without_colons:sym<f>($/) {
        ExtNode<140204309020984>
    }
}


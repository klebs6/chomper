#--------------------------
# A path with no type parameters;
# e.g. `foo::bar::Baz`
#
# These show up in 'use' view-items, because these
# are processed without respect to types.
our class ViewPath {
    has $.base is required;
    has Ident @.tail;
}

our class PathNoTypesAllowed::Rules {

    proto rule path-no-types-allowed-base { * }

    rule path-no-types-allowed-base:sym<a> { <ident> }
    rule path-no-types-allowed-base:sym<b> { <MOD-SEP>? <SELF> }
    rule path-no-types-allowed-base:sym<c> { <MOD-SEP>? <SUPER> }

    rule path-no-types-allowed {  
        <path-no-types-allowed-base> [<MOD-SEP> <ident>]*
    }
}

our class PathNoTypesAllowed::Actions {

    method path-no-types-allowed($/) {
        make ViewPath.new(
            base =>  $<path-no-types-allowed-base>.made,
            tail =>  $<ident>>>.made,
        )
    }

    method path-no-types-allowed:sym-base<a>($/) { make $<ident>.made }
    method path-no-types-allowed:sym<b>($/)      { make $<SELF>.made }
    method path-no-types-allowed:sym<c>($/)      { make $<SUPER>.made }
}

#--------------------------
# A path with a lifetime and type parameters, with
# no double colons before the type parameters;
# e.g. `foo::bar<'a>::Baz<T>`
#
# These show up in "trait references", the
# components of type-parameter bounds lists, as
# well as in the prefix of the
# path-generic-args-and-bounds rule, which is the
# full form of a named typed expression.
#
# They do not have (nor need) an extra '::' before
# '<' because unlike in expr context, there are no
# "less-than" type exprs to be ambiguous with.
our class Components {
    has $.maybe-ty-sums;
    has $.generic-args;
    has $.ret-ty;
    has $.ident;
}

our class PathGenericArgsWithoutColons::Rules {

    rule path-generic-args-without-colons {  
        {self.set-prec(IDENT)}
        <path-generic-args-without-colons-item>+ %% <MOD-SEP>
    }

    proto rule path-generic-args-without-colons-item { * }

    rule path-generic-args-without-colons-item<a> { <ident> }
    rule path-generic-args-without-colons-item<b> { <ident> <generic-args> }
    rule path-generic-args-without-colons-item<c> { <ident> '(' <maybe-ty-sums> ')' <ret-ty> }
}

our class PathGenericArgsWithoutColons::Actions {

    method path-generic-args-without-colons($/) {
        make $<path-generic-args-without-colons-item>>>.made
    }

    method path-generic-args-without-colons-item:sym<a>($/) {
        make Components.new(
            ident =>  $<ident>.made,
        )
    }

    method path-generic-args-without-colons-item:sym<b>($/) {
        make Components.new(
            ident        =>  $<ident>.made,
            generic-args =>  $<generic-args>.made,
        )
    }

    method path-generic-args-without-colons-item:sym<c>($/) {
        make Components.new(
            ident         => $<ident>.made,
            maybe-ty-sums => $<maybe-ty-sums>.made,
            ret-ty        => $<ret-ty>.made,
        )
    }
}

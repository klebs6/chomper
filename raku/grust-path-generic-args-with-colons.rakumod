use grust-model;

#-------------------------------------
# A path with a lifetime and type parameters with
# double colons before the type parameters;
# e.g. `foo::bar::<'a>::Baz::<T>`
#
# These show up in expr context, in order to
# disambiguate from "less-than" expressions.
our role PathGenericArgsWithColons::Rules {

    rule path-generic-args-with-colons {  
        <path-generic-args-with-colons-prefix>
        <path-generic-args-with-colons-tail>*
    }

    proto rule path-generic-args-with-colons-prefix { * }
    rule path-generic-args-with-colons-prefix:sym<a> { <ident> }
    rule path-generic-args-with-colons-prefix:sym<b> { <SUPER> }

    proto rule path-generic-args-with-colons-tail { * }
    rule path-generic-args-with-colons-tail:sym<c> { <MOD-SEP> <ident> }
    rule path-generic-args-with-colons-tail:sym<d> { <MOD-SEP> <SUPER> }
    rule path-generic-args-with-colons-tail:sym<e> { <MOD-SEP> <generic-args> }
}

our role PathGenericArgsWithColons::Actions {

    method path-generic-args-with-colons($/) {
        make PathGenericArgsWithColons.new(
            prefix => $<path-generic-args-with-colons-prefix>.made,
            tail   => $<path-generic-args-with-colons-tail>>>.made,
        )
    }

    method path-generic-args-with-colons-prefix:sym<a>($/) {
        make Components.new(
            ident =>  $<ident>.made,
        )
    }

    method path-generic-args-with-colons-prefix:sym<b>($/) {
        make Super.new
    }

    method path-generic-args-with-colons-tail:sym<c>($/) { make $<ident>.made }
    method path-generic-args-with-colons-tail:sym<d>($/) { make $<SUPER>.made }
    method path-generic-args-with-colons-tail:sym<e>($/) { make $<generic-args>.made }
}


use grust-model;

our class PathGenericArgsWithColons {
    has $.base;
    has @.tail;
}

#-------------------------------------
# A path with a lifetime and type parameters with
# double colons before the type parameters;
# e.g. `foo::bar::<'a>::Baz::<t>`
#
# These show up in expr context, in order to
# disambiguate from "less-than" expressions.
our role PathGenericArgsWithColons::Rules {

    rule path-generic-args-with-colons {  
        <path-generic-args-with-colons-base>
        <path-generic-args-with-colons-tail>*
    }

    proto rule path-generic-args-with-colons-base { * }
    rule path-generic-args-with-colons-base:sym<b> { <kw-super> }
    rule path-generic-args-with-colons-base:sym<a> { <ident> }

    proto rule path-generic-args-with-colons-tail { * }
    rule path-generic-args-with-colons-tail:sym<e> { <tok-mod-sep> <generic-args> }
    rule path-generic-args-with-colons-tail:sym<d> { <tok-mod-sep> <kw-super> }
    rule path-generic-args-with-colons-tail:sym<c> { <tok-mod-sep> <ident> }
}

our role PathGenericArgsWithColons::Actions {

    method path-generic-args-with-colons($/) {
        make PathGenericArgsWithColons.new(
            base => $<path-generic-args-with-colons-base>.made,
            tail => $<path-generic-args-with-colons-tail>>>.made,
        )
    }

    method path-generic-args-with-colons-base:sym<a>($/) {
        make $<ident>.made
    }

    method path-generic-args-with-colons-base:sym<b>($/) {
        make Super.new
    }

    method path-generic-args-with-colons-tail:sym<c>($/) { make $<ident>.made }
    method path-generic-args-with-colons-tail:sym<d>($/) { make $<kw-super>.made }
    method path-generic-args-with-colons-tail:sym<e>($/) { make $<generic-args>.made }
}

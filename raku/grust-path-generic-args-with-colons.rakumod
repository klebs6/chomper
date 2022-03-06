use grust-model;

use Data::Dump::Tree;

our class PathGenericArgsWithColons {
    has $.base;
    has @.tail;
    has $.text;

    submethod TWEAK {
        self.gist;
    }

    method gist {
        if @.tail.elems gt 0 {
            say "need to write gist!";
            say $.text;
            ddt self;
            exit;
        } else {
            $.base.gist
        }
    }
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
            text => ~$/,
        )
    }

    method path-generic-args-with-colons-base:sym<a>($/) {
        make $<ident>.made
    }

    method path-generic-args-with-colons-base:sym<b>($/) {
        make Super.new(
            text => ~$/,
        )
    }

    method path-generic-args-with-colons-tail:sym<c>($/) { make $<ident>.made }
    method path-generic-args-with-colons-tail:sym<d>($/) { make $<kw-super>.made }
    method path-generic-args-with-colons-tail:sym<e>($/) { make $<generic-args>.made }
}

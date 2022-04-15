unit module Chomper::Rust::GrustVisibility;

use Data::Dump::Tree;

our class VisibilityPublic {
    method gist { "pub" }
}

our class VisibilityCrate {
    method gist { "pub(crate)" }
}

our class VisibilitySelf {
    method gist { "pub(self)" }
}

our class VisibilitySuper {
    method gist { "pub(super)" }
}

our class VisibilityInPath {
    has $.simple-path;

    has $.text;

    method gist {
        "pub(in " ~ $.simple-path.gist ~ ")"
    }
}

our role Visibility::Rules {
    proto rule visibility { * }

    rule visibility:sym<basic>   { <kw-pub> }
    rule visibility:sym<crate>   { <kw-pub> <tok-lparen> <kw-crate> <tok-rparen> }
    rule visibility:sym<self>    { <kw-pub> <tok-lparen> <kw-selfvalue>  <tok-rparen> }
    rule visibility:sym<super>   { <kw-pub> <tok-lparen> <kw-super> <tok-rparen> }
    rule visibility:sym<in-path> { <kw-pub> <tok-lparen> <kw-in> <simple-path> <tok-rparen> }
}

our role Visibility::Actions {

    method visibility:sym<basic>($/)   { 
        make VisibilityPublic.new
    }

    method visibility:sym<crate>($/)   { 
        make VisibilityCrate.new
    }

    method visibility:sym<self>($/)    { 
        make VisibilitySelf.new
    }

    method visibility:sym<super>($/)   { 
        make VisibilitySuper.new
    }

    method visibility:sym<in-path>($/) { 
        make VisibilityInPath.new(
            simple-path => $<simple-path>.made,
            text        => $/.Str,
        )
    }
}
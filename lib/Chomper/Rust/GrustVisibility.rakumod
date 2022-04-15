unit module Chomper::Rust::GrustVisibility;

use Data::Dump::Tree;

class VisibilityPublic is export {
    method gist { "pub" }
}

class VisibilityCrate is export {
    method gist { "pub(crate)" }
}

class VisibilitySelf is export {
    method gist { "pub(self)" }
}

class VisibilitySuper is export {
    method gist { "pub(super)" }
}

class VisibilityInPath is export {
    has $.simple-path;

    has $.text;

    method gist {
        "pub(in " ~ $.simple-path.gist ~ ")"
    }
}

package VisibilityGrammar is export {

    our role Rules {
        proto rule visibility { * }

        rule visibility:sym<basic>   { <kw-pub> }
        rule visibility:sym<crate>   { <kw-pub> <tok-lparen> <kw-crate> <tok-rparen> }
        rule visibility:sym<self>    { <kw-pub> <tok-lparen> <kw-selfvalue>  <tok-rparen> }
        rule visibility:sym<super>   { <kw-pub> <tok-lparen> <kw-super> <tok-rparen> }
        rule visibility:sym<in-path> { <kw-pub> <tok-lparen> <kw-in> <simple-path> <tok-rparen> }
    }

    our role Actions {

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
}

unit module Chomper::Rust::GrustReferencePatterns;

use Data::Dump::Tree;

class ReferencePatternRef is export {
    has Bool $.mutable;
    has $.pattern-without-range;

    has $.text;

    method gist {
        if $.mutable {
            '&' ~ 'mut ' ~ $.pattern-without-range.gist
        } else {
            '&' ~ $.pattern-without-range.gist
        }
    }
}

class ReferencePatternRefRef is export {
    has Bool $.mutable;
    has $.pattern-without-range;

    has $.text;

    method gist {
        if $.mutable {
            '&&' ~ 'mut ' ~ $.pattern-without-range.gist
        } else {
            '&&' ~ $.pattern-without-range.gist
        }
    }
}

package ReferencePatternGrammar is export {

    our role Rules {

        proto rule reference-pattern { * }

        rule reference-pattern:sym<ref> {
            <tok-and>
            <kw-mut>?
            <pattern-without-range>
        }

        rule reference-pattern:sym<refref> {
            <tok-andand>
            <kw-mut>?
            <pattern-without-range>
        }
    }

    our role Actions {

        method reference-pattern:sym<ref>($/)    { 
            make ReferencePatternRef.new(
                mutable               => so $/<kw-mut>:exists,
                pattern-without-range => $<pattern-without-range>.made,
                text                  => $/.Str,
            )
        }

        method reference-pattern:sym<refref>($/) { 
            make ReferencePatternRefRef.new(
                mutable               => so $/<kw-mut>:exists,
                pattern-without-range => $<pattern-without-range>.made,
                text                  => $/.Str,
            )
        }
    }
}

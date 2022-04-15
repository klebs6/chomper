unit module Chomper::Rust::GrustCrate;

use Data::Dump::Tree;

class Crate is export {
    has Bool $.bom;
    has Bool $.shebang;
    has @.inner-attributes;
    has @.crate-items;

    has $.text;

    method gist {

        my $builder = "";

        if $.bom {
            $builder ~= 0xFEFF.Str;
        }

        if $.shebang {
            $builder ~= "#!";
        }

        for @.inner-attributes {
            $builder ~= $_.gist ~ "\n";
        }

        for @.crate-items {
            $builder ~= $_.gist ~ "\n\n";
        }

        $builder
    }
}

class AsClause is export {
    has $.identifier-or-underscore;

    has $.text;

    method gist {
        "as " ~ $.identifier.or-underscore.gist
    }
}

class ExternCrate is export {
    has $.crate-ref;
    has $.maybe-as-clause;

    has $.text;

    method gist {

        my $builder = "extern crate ";

        $builder ~= $.crate-ref.gist;

        if $.maybe-as-clause {
            $builder ~= " " ~ $.maybe-as-clause.gist;
        }

        $builder ~ ";"
    }

    method name {
        $.crate-ref.gist
    }

    method has-name {
        True
    }
}

package CrateGrammar is export {

    our role Rules {

        rule crate {
            <utf8-bom>?
            <shebang>?
            <inner-attribute>*
            <crate-item>*
        }

        token utf8-bom {
            \x[FEFF]
        }

        token shebang {
            <tok-shebang> \N+
        }

        rule as-clause {
            <kw-as>
            <identifier-or-underscore>
        }

        rule extern-crate {
            <kw-extern>
            <kw-crate>
            <crate-ref>
            <as-clause>?
            <tok-semi>
        }

        proto rule crate-ref { * }

        rule crate-ref:sym<id>   { <identifier> }
        rule crate-ref:sym<self> { <kw-selfvalue> }
    }

    our role Actions {

        method crate($/) {
            make Crate.new(
                bom              => so $/<utf8-bom>:exists,
                shebang          => so $/<shebang>:exists,
                inner-attributes => $<inner-attribute>>>.made,
                crate-items      => $<crate-item>>>.made,
                text             => $/.Str,
            )
        }

        method as-clause($/) {
            make AsClause.new(
                identifier-or-underscore => $<identifier-or-underscore>.made,
                text                     => $/.Str,
            )
        }

        method extern-crate($/) {
            make ExternCrate.new(
                crate-ref       => $<crate-ref>.made,
                maybe-as-clause => $<as-clause>.made,
                text            => $/.Str,
            )
        }

        method crate-ref:sym<id>($/)   { make $<identifier>.made }
        method crate-ref:sym<self>($/) { make $<kw-selfvalue>.made }
    }
}

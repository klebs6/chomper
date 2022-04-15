unit module Chomper::Rust::GrustTypeAlias;

use Data::Dump::Tree;

our class TypeAlias {
    has $.identifier;
    has $.maybe-generic-params;
    has $.maybe-type-param-bounds;
    has $.maybe-where-clause;
    has $.maybe-eq-type;

    has $.text;

    method has-name {
        True
    }

    method name {
        $.identifier.gist
    }

    method gist {

        my $builder = "type " ~ $.identifier.gist;

        if $.maybe-generic-params {
            $builder ~= $.maybe-generic-params.gist;
        }

        if $.maybe-type-param-bounds {
            $builder ~= ": " ~ $.maybe-type-param-bounds.gist;
        }

        if $.maybe-where-clause {
            $builder ~= "\n" ~ $.maybe-where-clause.gist ~ "\n";
        }

        if $.maybe-eq-type {
            $builder ~= " = " ~ $.maybe-eq-type.gist;
        }

        $builder ~ ";"
    }
}

our role TypeAlias::Rules {

    rule type-alias {
        <kw-default>?
        <kw-type>
        <identifier>
        <generic-params>?
        [ <tok-colon> <type-param-bounds> ]?
        <where-clause>?
        [ <tok-eq> <type>]?
        <tok-semi>
    }
}

our role TypeAlias::Actions {

    method type-alias($/) {
        make TypeAlias.new(
            identifier              => $<identifier>.made,
            maybe-generic-params    => $<generic-params>.made,
            maybe-type-param-bounds => $<type-param-bounds>.made,
            maybe-where-clause      => $<where-clause>.made,
            maybe-eq-type           => $<type>.made,
            text                    => $/.Str,
        )
    }
}
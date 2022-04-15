unit module Chomper::Rust::GrustTraitObjects;

use Data::Dump::Tree;

class TraitObjectType is export {
    has Bool $.dyn;
    has $.type-param-bounds;

    has $.text;

    method gist {

        my $builder = "";

        if $.dyn {
            $builder ~= "dyn ";
        }

        $builder ~ $.type-param-bounds.gist
    }
}

class TraitObjectTypeOneBound is export {
    has Bool $.dyn;
    has $.trait-bound;

    has $.text;

    method gist {
        my $builder = "";

        if $.dyn {
            $builder ~= "dyn ";
        }

        $builder ~ $.trait-bound.gist
    }
}

package TraitObjectTypeGrammar is export {

    our role Rules {

        rule trait-object-type {
            <kw-dyn>? 
            <type-param-bounds>
        }

        rule trait-object-type-one-bound {
            <kw-dyn>?
            <trait-bound>
        }
    }

    our role Actions {

        method trait-object-type($/) {
            make TraitObjectType.new(
                dyn               => so $/<kw-dyn>:exists,
                type-param-bounds => $<type-param-bounds>.made,
                text              => $/.Str,
            )
        }

        method trait-object-type-one-bound($/) {
            make TraitObjectTypeOneBound.new(
                dyn         => so $/<kw-dyn>:exists,
                trait-bound => $<trait-bound>.made,
                text        => $/.Str,
            )
        }
    }
}

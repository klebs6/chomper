unit module Chomper::Rust::GrustImplTrait;

use Data::Dump::Tree;

class ImplTraitType is export {
    has $.type-param-bounds;

    has $.text;

    method gist {
        "impl " ~ $.type-param-bounds.gist
    }
}

class ImplTraitTypeOneBound is export {
    has $.trait-bound;

    has $.text;

    method gist {
        "impl " ~ $.trait-bound.gist
    }
}

package ImplTraitTypeGrammar is export {

    our role Rules {

        rule impl-trait-type {
            <kw-impl>
            <type-param-bounds>
        }

        rule impl-trait-type-one-bound {
            <kw-impl>
            <trait-bound>
        }
    }

    our role Actions {

        method impl-trait-type($/) {
            make ImplTraitType.new(
                type-param-bounds => $<type-param-bounds>.made,
                text              => $/.Str,
            )
        }

        method impl-trait-type-one-bound($/) {
            make ImplTraitTypeOneBound.new(
                trait-bound => $<trait-bound>.made,
                text        => $/.Str,
            )
        }
    }
}

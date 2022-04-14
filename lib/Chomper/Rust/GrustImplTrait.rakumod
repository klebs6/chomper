use Data::Dump::Tree;

our class ImplTraitType {
    has $.type-param-bounds;

    has $.text;

    method gist {
        "impl " ~ $.type-param-bounds.gist
    }
}

our class ImplTraitTypeOneBound {
    has $.trait-bound;

    has $.text;

    method gist {
        "impl " ~ $.trait-bound.gist
    }
}

our role ImplTraitType::Rules {

    rule impl-trait-type {
        <kw-impl>
        <type-param-bounds>
    }

    rule impl-trait-type-one-bound {
        <kw-impl>
        <trait-bound>
    }
}

our role ImplTraitType::Actions {

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

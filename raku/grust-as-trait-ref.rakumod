our class AsTraitRef::Rules {
    rule maybe-as_trait_ref {
        [<AS> <trait-ref>]?
    }
}

our class AsTraitRef::Actions {
    method maybe-as_trait_ref($/) {
        make $<trait_ref>.made
    }
}

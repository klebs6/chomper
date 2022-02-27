use grust-model;

our role AsTraitRef::Rules {
    rule maybe-as_trait_ref {
        [<AS> <trait-ref>]?
    }
}

our role AsTraitRef::Actions {
    method maybe-as_trait_ref($/) {
        make $<trait_ref>.made
    }
}

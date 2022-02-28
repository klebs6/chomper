use grust-model;

our role AsTraitRef::Rules {
    rule maybe-as-trait-ref {
        [<as_> <trait-ref>]?
    }
}

our role AsTraitRef::Actions {
    method maybe-as-trait-ref($/) {
        make $<trait-ref>.made
    }
}

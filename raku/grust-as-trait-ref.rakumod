our class AsTraitRef::Rules {

    proto rule maybe-as_trait_ref { * }

    rule maybe-as_trait_ref:sym<a> {
        <AS> <trait-ref>
    }

    rule maybe-as_trait_ref:sym<b> {

    }
}

our class AsTraitRef::Actions {

    method maybe-as_trait_ref:sym<a>($/) {
        make $<trait_ref>.made
    }

    method maybe-as_trait_ref:sym<b>($/) {
        MkNone<140417796742176>
    }
}

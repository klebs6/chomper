use grust-model;

our role TyAscription::Rules {

    rule maybe-ty-ascription {
        [':' <ty-sum>]?
    }
}

our role TyAscription::Actions {

    method maybe-ty-ascription($/) {
        make $<ty-sum>.made
    }
}




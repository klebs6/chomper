our class TyAscription::Rules {

    rule maybe-ty-ascription {
        [':' <ty-sum>]?
    }
}

our class TyAscription::Actions {

    method maybe-ty-ascription($/) {
        make $<ty-sum>.made
    }
}



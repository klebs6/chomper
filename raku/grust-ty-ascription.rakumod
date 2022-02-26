our class TyAscription::Rules {

    rule maybe-ty_ascription {
        [':' <ty-sum>]?
    }
}

our class TyAscription::Actions {

    method maybe-ty_ascription($/) {
        make $<ty_sum>.made
    }
}


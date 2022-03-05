use grust-model;

our role TyAscription::Rules {

    rule ty-ascription {
        ':' <ty-sum>
    }

    rule maybe-ty-ascription {
        <ty-ascription>?
    }
}

our role TyAscription::Actions {

    method ty-ascription($/) {
        make TyAscription.new(
            value => $<ty-sum>.made
        )
    }

    method maybe-ty-ascription($/) {
        make $<ty-ascription>.made
    }
}

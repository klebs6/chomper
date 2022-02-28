use grust-model;


our role TyDefault::Rules {

    rule maybe-ty-default {
        ['=' <ty-sum>]?
    }
}

our role TyDefault::Actions {

    method maybe-ty-default($/) {
        make TyDefault.new(
            ty-sum =>  $<ty-sum>.made,
        )
    }
}


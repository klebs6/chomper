our class TyDefault {
    has $.ty-sum;
}

our class TyDefault::Rules {

    rule maybe-ty-default {
        ['=' <ty-sum>]?
    }
}

our class TyDefault::Actions {

    method maybe-ty-default($/) {
        make TyDefault.new(
            ty-sum =>  $<ty-sum>.made,
        )
    }
}

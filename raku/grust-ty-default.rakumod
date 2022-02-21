our class TyDefault {
    has $.ty_sum;
}

our class TyDefault::Rules {

    proto rule maybe-ty_default { * }

    rule maybe-ty_default:sym<a> {
        '=' <ty-sum>
    }

    rule maybe-ty_default:sym<b> {

    }
}

our class TyDefault::Actions {

    method maybe-ty_default:sym<a>($/) {
        make TyDefault.new(
            ty-sum =>  $<ty-sum>.made,
        )
    }

    method maybe-ty_default:sym<b>($/) {
        MkNone<140350942994944>
    }
}

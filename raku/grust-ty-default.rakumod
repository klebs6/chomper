our class TyDefault {
    has $.ty_sum;
}

our class TyDefault::G {

    proto rule maybe-ty_default { * }

    rule maybe-ty_default:sym<a> {
        '=' <ty-sum>
    }

    rule maybe-ty_default:sym<b> {

    }
}

our class TyDefault::A {

    method maybe-ty_default:sym<a>($/) {
        make TyDefault.new(
            ty-sum =>  $<ty-sum>.made,
        )
    }

    method maybe-ty_default:sym<b>($/) {
        MkNone<140350942994944>
    }
}

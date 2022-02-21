our class TyAscription::G {

    proto rule maybe-ty_ascription { * }

    rule maybe-ty_ascription:sym<a> {
        ':' <ty-sum>
    }

    rule maybe-ty_ascription:sym<b> {

    }
}

our class TyAscription::A {

    method maybe-ty_ascription:sym<a>($/) {
        make $<ty_sum>.made
    }

    method maybe-ty_ascription:sym<b>($/) {
        MkNone<140492181301024>
    }
}


our class TyParams {
    has $.ty_param;
}

our class TyParams::G {

    proto rule ty-params { * }

    rule ty-params:sym<a> {
        <ty-param>
    }

    rule ty-params:sym<b> {
        <ty-params> ',' <ty-param>
    }
}

our class TyParams::A {

    method ty-params:sym<a>($/) {
        make TyParams.new(
            ty-param =>  $<ty-param>.made,
        )
    }

    method ty-params:sym<b>($/) {
        ExtNode<140699547191112>
    }
}

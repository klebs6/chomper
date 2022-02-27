our class TyParams {
    has $.ty_param;
}

our class TyParams::Rules {

    rule ty-params {
        <ty-param>+ %% ","
    }
}

our class TyParams::Actions {

    method ty-params($/) {
        make $<ty-param>.made
    }
}

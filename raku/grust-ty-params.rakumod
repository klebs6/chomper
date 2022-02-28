use grust-model;


our role TyParams::Rules {

    rule ty-params {
        <ty-param>+ %% ","
    }
}

our role TyParams::Actions {

    method ty-params($/) {
        make $<ty-param>.made
    }
}


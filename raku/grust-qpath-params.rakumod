use grust-model;

our role QPathParams::Rules {

    rule maybe-qpath-params {
        [<mod-sep> <generic-args>]?
    }
}

our role QPathParams::Actions {

    method maybe-qpath-params:sym<a>($/) {
        make $<generic-args>.made
    }
}

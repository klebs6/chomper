our class QPathParams::Rules {

    proto rule maybe-qpath_params { * }

    rule maybe-qpath_params:sym<a> {
        <MOD-SEP> <generic-args>
    }

    rule maybe-qpath_params:sym<b> {

    }
}

our class QPathParams::Actions {

    method maybe-qpath_params:sym<a>($/) {
        make $<generic_args>.made
    }

    method maybe-qpath_params:sym<b>($/) {
        MkNone<140654400390368>
    }
}

our class Default::Rules {

    proto rule maybe-default { * }

    rule maybe-default:sym<a> {
        <DEFAULT>
    }

    rule maybe-default:sym<b> {

    }
}

our class Default::Actions {

    method maybe-default:sym<a>($/) {
        make Default.new
    }

    method maybe-default:sym<b>($/) {
        MkNone<140252405044640>
    }
}

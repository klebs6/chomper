our class Default::G {

    proto rule maybe-default { * }

    rule maybe-default:sym<a> {
        <DEFAULT>
    }

    rule maybe-default:sym<b> {

    }
}

our class Default::A {

    method maybe-default:sym<a>($/) {
        make Default.new
    }

    method maybe-default:sym<b>($/) {
        MkNone<140252405044640>
    }
}

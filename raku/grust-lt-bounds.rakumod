our class Ltbounds {
    has $.lifetime;
}

our class LtBounds::G {

    proto rule maybe-ltbounds { * }

    rule maybe-ltbounds:sym<a> {
        {self.set-prec(SHIFTPLUS)} ':' <ltbounds>
    }

    rule maybe-ltbounds:sym<b> {

    }

    proto rule ltbounds { * }

    rule ltbounds:sym<a> {
        <lifetime>
    }

    rule ltbounds:sym<b> {
        <ltbounds> '+' <lifetime>
    }
}

our class LtBounds::A {

    method maybe-ltbounds:sym<a>($/) {
        make $<ltbounds>.made
    }

    method maybe-ltbounds:sym<b>($/) {
        MkNone<140308387816480>
    }

    method ltbounds:sym<a>($/) {
        make ltbounds.new(
            lifetime =>  $<lifetime>.made,
        )
    }

    method ltbounds:sym<b>($/) {
        ExtNode<140310419243344>
    }
}

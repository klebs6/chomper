our class Bounds {
    has $.bound;
}

our class Bounds::Rules {

    proto rule maybe-bounds { * }

    rule maybe-bounds:sym<a> {
        {self.set-prec(SHIFTPLUS)} ':' <bounds>
    }

    rule maybe-bounds:sym<b> {
        # %prec SHIFTPLUS 
    }

    proto rule bounds { * }

    rule bounds:sym<a> {
        <bound>
    }

    rule bounds:sym<b> {
        <bounds> '+' <bound>
    }

    proto rule bound { * }

    rule bound:sym<a> {
        <lifetime>
    }

    rule bound:sym<b> {
        <trait-ref>
    }
}

our class Bounds::Actions {

    method maybe-bounds:sym<a>($/) {
        make $<bounds>.made
    }

    method maybe-bounds:sym<b>($/) {
        MkNone<140424370458624>
    }

    method bounds:sym<a>($/) {
        make bounds.new(
            bound =>  $<bound>.made,
        )
    }

    method bounds:sym<b>($/) {
        ExtNode<140424375574320>
    }

    method bound:sym<a>($/) {
        make $<lifetime>.made
    }

    method bound:sym<b>($/) {
        make $<trait-ref>.made
    }
}

our class Ltbounds {
    has $.lifetime;
}

our class LtBounds::Rules {

    rule maybe-ltbounds {
        {self.set-prec(SHIFTPLUS)} [':' <ltbounds>]?
    }

    rule ltbounds {
        <lifetime>+ %% "+"
    }
}

our class LtBounds::Actions {

    method maybe-ltbounds($/) {
        make $<ltbounds>.made
    }

    method ltbounds($/) {
        make $<lifetime>>>.made
    }
}

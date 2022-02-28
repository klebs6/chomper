use grust-model;


our role LtBounds::Rules {

    rule maybe-ltbounds {
        #{self.set-prec(SHIFTPLUS)} 
        [':' <ltbounds>]?
    }

    rule ltbounds {
        <lifetime>+ %% "+"
    }
}

our role LtBounds::Actions {

    method maybe-ltbounds($/) {
        make $<ltbounds>.made
    }

    method ltbounds($/) {
        make $<lifetime>>>.made
    }
}


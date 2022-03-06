use grust-model;

our role ForLifetimes::Rules {

    rule maybe-for-lifetimes {
        [<kw-for> '<' <lifetimes> '>']?
    }
}

our role ForLifetimes::Actions {

    method maybe-for-lifetimes($/) {
        make ForLifetimes.new(
            lifetimes => $<lifetimes>.made,
            text      => ~$/,
        )
    }
}

use grust-model;

our role ForLifetimes::Rules {

    rule maybe-for-lifetimes {
        [<kw-for> '<' <lifetimes> '>']?
    }
}

our role ForLifetimes::Actions {

    method maybe-for-lifetimes($/) {
        #MkNone<140569789206720>
    }
}

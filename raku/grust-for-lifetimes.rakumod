use grust-model;

our role ForLifetimes::Rules {

    rule maybe-for_lifetimes {
        [<FOR> '<' <lifetimes> '>']?
    }
}

our role ForLifetimes::Actions {

    method maybe-for_lifetimes($/) {
        #MkNone<140569789206720>
    }
}

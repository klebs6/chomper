our class ForLifetimes::Rules {

    rule maybe-for_lifetimes {
        [<FOR> '<' <lifetimes> '>']?
    }
}

our class ForLifetimes::Actions {

    method maybe-for_lifetimes($/) {
        #MkNone<140569789206720>
    }
}

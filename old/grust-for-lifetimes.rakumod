use Data::Dump::Tree;

our class ForLifetimes {
    has $.lifetimes;

    has $.text;

    submethod TWEAK {
        say self.gist;
    }

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

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

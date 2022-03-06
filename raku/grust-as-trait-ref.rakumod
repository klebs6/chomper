our class AsTraitRef {
    has $.trait-ref;

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

our role AsTraitRef::Rules {
    rule maybe-as-trait-ref {
        [<kw-as> <trait-ref>]?
    }
}

our role AsTraitRef::Actions {
    method maybe-as-trait-ref($/) {
        if $/<trait-ref>:exists {
            make AsTraitRef.new(
                trait-ref => $<trait-ref>.made,
                text      => ~$/,
            )
        }
    }
}

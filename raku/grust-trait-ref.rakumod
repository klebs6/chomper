our class TraitRef {
    has $.value;

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

our role TraitRef::Rules {

    rule trait-ref {
        <tok-mod-sep>? 
        <path-generic-args-without-colons>
    }
}

our role TraitRef::Actions {

    method trait-ref($/) {
        make TraitRef.new(
            value => $<path-generic-args-without-colons>.made,
            text  => ~$/,
        )
    }
}

our class Crate {
    has $.maybe-mod-items;
    has $.inner-attrs;

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

our role Crate::Rules {

    rule crate {
        <maybe-shebang> 
        <inner-attrs>? 
        <maybe-mod-items>
    }

    rule maybe-shebang {
        <shebang-line>?
    }
}

our role Crate::Actions {

    method crate($/) {
        make Crate.new(
            shebang         => $<maybe-shebang>.made,
            inner-attrs     => $<inner-attrs>.made // Nil,
            maybe-mod-items => $<maybe-mod-items>.made,
            text            => ~$/,
        )
    }

    method maybe-shebang($/) {
        make $<shebang-line>.made
    }
}

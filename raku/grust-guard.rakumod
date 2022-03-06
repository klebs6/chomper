our class Guard {
    has $.expr-nostruct;

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

our role Guard::Rules {

    rule maybe-guard {
        [ <kw-if> <expr-nostruct> ]?
    }
}

our role Guard::Actions {

    method maybe-guard($/) {
        make Guard.new(
            expr-nostruct => $<expr-nostruct>.made,
            text          => ~$/,
        )
    }
}

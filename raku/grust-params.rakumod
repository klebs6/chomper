our class Arg {
    has $.ty-sum;
    has $.pat;

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

our role Params::Rules {

    rule maybe-params {
        [<params> ','? ]?
    }

    rule params {
        <param>+ %% ","
    }

    rule param {
        <comment>?
        <pat> ':' <ty-sum>
    }

    rule maybe-comma-params {
        [ ',' [<params> ','?]? ]?
    }
}

our role Params::Actions {

    method maybe-params($/) {
        make $<params>.made
    }

    method params($/) {
        make $<param>>>.made
    }

    method param($/) {
        make Arg.new(
            comment => $<comment>.made,
            pat     => $<pat>.made,
            ty-sum  => $<ty-sum>.made,
            text    => ~$/,
        )
    }

    method maybe-comma-params($/) {
        make $<params>.made
    }
}

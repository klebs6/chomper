our class Arg {
    has $.ty-sum;
    has $.pat;
}

our class Args {
    has $.param;
}

our class Params::Rules {

    rule maybe-params {
        [<params> ','? ]?
    }

    rule params {
        <param>+ %% ","
    }

    rule param {
        <pat> ':' <ty-sum>
    }

    proto rule maybe-comma-params { * }

    rule maybe-comma-params {
        [ ',' [<params> ','?]? ]?
    }
}

our class Params::Actions {

    method maybe-params($/) {
        make $<params>.made
    }

    method params($/) {
        make $<param>>>.made
    }

    method param($/) {
        make Arg.new(
            pat    => $<pat>.made,
            ty-sum => $<ty-sum>.made,
        )
    }

    method maybe-comma-params($/) {
        make $<params>.made
    }
}

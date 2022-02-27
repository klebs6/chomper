use grust-model;


our role Params::Rules {

    rule maybe-params {
        [<params> ','? ]?
    }

    rule params {
        <param>+ %% ","
    }

    rule param {
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
            pat    => $<pat>.made,
            ty-sum => $<ty-sum>.made,
        )
    }

    method maybe-comma-params($/) {
        make $<params>.made
    }
}

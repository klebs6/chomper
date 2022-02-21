our class Arg {
    has $.ty_sum;
    has $.pat;
}

our class Args {
    has $.param;
}

our class Params::G {

    proto rule maybe-params { * }

    rule maybe-params:sym<a> {
        <params>
    }

    rule maybe-params:sym<b> {
        <params> ','
    }

    rule maybe-params:sym<c> {

    }

    proto rule params { * }

    rule params:sym<a> {
        <param>
    }

    rule params:sym<b> {
        <params> ',' <param>
    }

    rule param {
        <pat> ':' <ty-sum>
    }

    proto rule maybe-comma_params { * }

    rule maybe-comma_params:sym<a> {
        ','
    }

    rule maybe-comma_params:sym<b> {
        ',' <params>
    }

    rule maybe-comma_params:sym<c> {
        ',' <params> ','
    }

    rule maybe-comma_params:sym<d> {

    }
}

our class Params::A {

    method maybe-params:sym<a>($/) {
        make $<params>.made
    }

    method maybe-params:sym<b>($/) {

    }

    method maybe-params:sym<c>($/) {
        MkNone<140389581740544>
    }

    method params:sym<a>($/) {
        make Args.new(
            param =>  $<param>.made,
        )
    }

    method params:sym<b>($/) {
        ExtNode<140389582675544>
    }

    method param($/) {
        make Arg.new(
            pat    =>  $<pat>.made,
            ty-sum =>  $<ty-sum>.made,
        )
    }

    method maybe-comma_params:sym<a>($/) {
        MkNone<140389582707232>
    }

    method maybe-comma_params:sym<b>($/) {
        make $<params>.made
    }

    method maybe-comma_params:sym<c>($/) {
        make $<params>.made
    }

    method maybe-comma_params:sym<d>($/) {
        MkNone<140389582707264>
    }
}


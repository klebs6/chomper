use grust-model;


our role LitOrPath::Rules {

    proto rule lit-or_path { * }

    rule lit-or_path:sym<a> { <path-expr> }
    rule lit-or_path:sym<b> { <lit> }
    rule lit-or_path:sym<c> { '-' <lit> }
}

our role LitOrPath::Actions {

    method lit-or_path:sym<a>($/) {
        make PatLit.new(
            path-expr =>  $<path-expr>.made,
        )
    }

    method lit-or_path:sym<b>($/) {
        make PatLit.new(
            lit =>  $<lit>.made,
        )
    }

    method lit-or_path:sym<c>($/) {
        make PatLit.new(
            lit =>  $<lit>.made,
        )
    }
}

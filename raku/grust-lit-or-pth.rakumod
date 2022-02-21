our class PatLit {
    has $.lit;
    has $.path_expr;
}

our class LitOrPath::G {

    proto rule lit-or_path { * }

    rule lit-or_path:sym<a> {
        <path-expr>
    }

    rule lit-or_path:sym<b> {
        <lit>
    }

    rule lit-or_path:sym<c> {
        '-' <lit>
    }
}

our class LitOrPath::A {

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

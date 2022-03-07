use Data::Dump::Tree;

our class PatLit {
    has $.lit;

    has $.text;

    method gist {
        $.lit.gist
    }
}

our class PatLitPath {
    has $.path-expr;

    has $.text;

    method gist {
        $.path-expr>>.gist.join("")
    }
}

our role LitOrPath::Rules {

    proto rule lit-or-path { * }

    rule lit-or-path:sym<a> { <path-expr> }
    rule lit-or-path:sym<b> { <lit> }
    rule lit-or-path:sym<c> { '-' <lit> }
}

our role LitOrPath::Actions {

    method lit-or-path:sym<a>($/) {
        make PatLitPath.new(
            path-expr =>  $<path-expr>.made,
            text      => ~$/,
        )
    }

    method lit-or-path:sym<b>($/) {
        make PatLit.new(
            lit  =>  $<lit>.made,
            text => ~$/,
        )
    }

    method lit-or-path:sym<c>($/) {
        make PatLit.new(
            lit  =>  $<lit>.made,
            text => ~$/,
        )
    }
}

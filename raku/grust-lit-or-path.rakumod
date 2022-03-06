our class PatLit {
    has $.lit;
    has $.path-expr;

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

our role LitOrPath::Rules {

    proto rule lit-or-path { * }

    rule lit-or-path:sym<a> { <path-expr> }
    rule lit-or-path:sym<b> { <lit> }
    rule lit-or-path:sym<c> { '-' <lit> }
}

our role LitOrPath::Actions {

    method lit-or-path:sym<a>($/) {
        make PatLit.new(
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

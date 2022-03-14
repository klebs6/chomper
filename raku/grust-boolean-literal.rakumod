our class BooleanLiteral {
    has Bool $.value;

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

our role BooleanLiteral::Rules {

    proto token boolean-literal { * }
    token boolean-literal:sym<t> { true }
    token boolean-literal:sym<f> { false }
}

our role BooleanLiteral::Actions {
    method boolean-literal:sym<t>($/) { make BooleanLiteral.new(value => True) }
    method boolean-literal:sym<f>($/) { make BooleanLiteral.new(value => False) }
}

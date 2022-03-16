use Data::Dump::Tree;

our class BooleanLiteral {
    has Bool $.value;

    method gist {
        $.value.Str
    }
}

our role BooleanLiteral::Rules {

    proto token boolean-literal { * }
    token boolean-literal:sym<t> { true }
    token boolean-literal:sym<f> { false }
}

our role BooleanLiteral::Actions {

    method boolean-literal:sym<t>($/) { 
        make BooleanLiteral.new(
            value => True
        )
    }

    method boolean-literal:sym<f>($/) { 
        make BooleanLiteral.new(
            value => False
        )
    }
}

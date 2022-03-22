use Data::Dump::Tree;

use gcpp-roles;

our class BooleanLiteral::F does IBooleanLiteral { 

    has $.text;

    method gist {
        "False"
    }
}

our class BooleanLiteral::T does IBooleanLiteral { 

    has $.text;

    method gist {
        "True"
    }
}

our role BooleanLiteral::Actions {

    # token boolean-literal:sym<f> { <false_> }
    method boolean-literal:sym<f>($/) {
        make BooleanLiteral::F.new
    }

    # token boolean-literal:sym<t> { <true_> }
    method boolean-literal:sym<t>($/) {
        make BooleanLiteral::T.new
    }
}

our role BooleanLiteral::Rules {

    proto token boolean-literal { * }
    token boolean-literal:sym<f> { <false_> }
    token boolean-literal:sym<t> { <true_> }
}

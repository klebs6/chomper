unit module Chomper::Cpp::GcppPtr;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;

# token literal:sym<ptr> { <pointer-literal> }
our class PointerLiteral does ILiteral {

    has $.text;

    method gist(:$treemark=False) {
        "nullptr"
    }
}

our role PointerLiteral::Actions {

    # token pointer-literal { <nullptr> } 
    method pointer-literal($/) {
        make PointerLiteral.new
    }
}

our role PointerLiteral::Rules {

    token pointer-literal {
        <nullptr>
    }
}
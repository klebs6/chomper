unit module Chomper::Cpp::GcppPtr;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;

# token literal:sym<ptr> { <pointer-literal> }
class PointerLiteral does ILiteral is export {

    has $.text;

    method name {
        'PointerLiteral'
    }

    method gist(:$treemark=False) {
        "nullptr"
    }
}

package PointerLiteralGrammar is export {

    our role Actions {

        # token pointer-literal { <nullptr> } 
        method pointer-literal($/) {
            make PointerLiteral.new
        }
    }

    our role Rules {

        token pointer-literal {
            <nullptr>
        }
    }
}

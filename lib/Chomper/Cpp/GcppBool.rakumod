unit module Chomper::Cpp::GcppBool;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;

package BooleanLiteral is export {

    our class F does IBooleanLiteral { 

        has $.text;

        method name {
            'BooleanLiteral::F'
        }

        method gist(:$treemark=False) {
            "false"
        }
    }

    our class T does IBooleanLiteral { 

        has $.text;

        method name {
            'BooleanLiteral::T'
        }

        method gist(:$treemark=False) {
            "true"
        }
    }
}

package BooleanLiteralGrammar is export {

    our role Actions {

        # token boolean-literal:sym<f> { <false_> }
        method boolean-literal:sym<f>($/) {
            make BooleanLiteral::F.new
        }

        # token boolean-literal:sym<t> { <true_> }
        method boolean-literal:sym<t>($/) {
            make BooleanLiteral::T.new
        }
    }

    our role Rules {

        proto token boolean-literal { * }
        token boolean-literal:sym<f> { <false_> }
        token boolean-literal:sym<t> { <true_> }
    }
}

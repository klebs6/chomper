unit module Chomper::Rust::GrustBooleanLiteral;

use Data::Dump::Tree;

class BooleanLiteral is export {
    has $.value;

    method gist {
        $.value
    }
}

package BooleanLiteralGrammar is export {

    our role Rules {

        proto token boolean-literal { * }
        token boolean-literal:sym<t> { true }
        token boolean-literal:sym<f> { false }
    }

    our role Actions {

        method boolean-literal:sym<t>($/) { 
            make BooleanLiteral.new(
                value => ~$/
            )
        }

        method boolean-literal:sym<f>($/) { 
            make BooleanLiteral.new(
                value => ~$/
            )
        }
    }
}

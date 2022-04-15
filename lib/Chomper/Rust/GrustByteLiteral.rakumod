unit module Chomper::Rust::GrustByteLiteral;

use Data::Dump::Tree;

class ByteLiteral is export {
    has $.value;

    method gist {
        $.value
    }
}

package ByteLiteralGrammar is export {
    our role Rules {

        token byte-literal {
            b 
            <tok-single-quote> 
            [ <ascii-for-char> | <byte-escape> ] 
            <tok-single-quote>
        }

        proto token byte-escape { * }

        token byte-escape:sym<x>  { \\x <hex-digit> <hex-digit> }
        token byte-escape:sym<n>  { \\n }
        token byte-escape:sym<r>  { \\r }
        token byte-escape:sym<t>  { \\t }
        token byte-escape:sym<sl> { \\\\ }
        token byte-escape:sym<s0> { \\0 }
        token byte-escape:sym<sq> { \\\' }
        token byte-escape:sym<dq> { \\\" }
    }

    our role Actions {
        method byte-literal($/) {
            make ByteLiteral.new(
                value => $/.Str
            )
        }
    }
}

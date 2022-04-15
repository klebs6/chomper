unit module Chomper::Rust::GrustIntLiteral;

use Data::Dump::Tree;

class IntegerLiteral is export {
    has $.value;

    method gist {
        $.value
    }
}

package IntLiteralGrammar is export {

    our role Rules {

        proto token integer-suffix { * }
        token integer-suffix:sym<u8>    { u8 }
        token integer-suffix:sym<u16>   { u16 }
        token integer-suffix:sym<u32>   { u32 }
        token integer-suffix:sym<u64>   { u64 }
        token integer-suffix:sym<u128>  { u128 }
        token integer-suffix:sym<usize> { usize }
        token integer-suffix:sym<i8>    { i8 }
        token integer-suffix:sym<i16>   { i16 }
        token integer-suffix:sym<i32>   { i32 }
        token integer-suffix:sym<i64>   { i64 }
        token integer-suffix:sym<i128>  { i128 }
        token integer-suffix:sym<isize> { isize }

        token integer-literal {
            <integer-literal-variant> <integer-suffix>?
        }

        proto token integer-literal-variant { * }

        token integer-literal-variant:sym<bin> { <bin-literal> }
        token integer-literal-variant:sym<oct> { <oct-literal> }
        token integer-literal-variant:sym<hex> { <hex-literal> }
        token integer-literal-variant:sym<dec> { <dec-literal> }

        token dec-literal {
            <dec-digit> [<dec-digit> | _]*
        }

        token bin-literal { 0b <bin-digit>+ }
        token oct-literal { 0o <oct-digit>+ }
        token hex-literal { 0x <hex-digit>+ }

        token bin-digit { <[0..1 _]> }
        token oct-digit { <[0..7 _]> }
        token dec-digit { <[0..9 _]> }
        token hex-digit { <[0..9 a..f A..F _]> }
    }
}

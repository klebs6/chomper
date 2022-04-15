unit module Chomper::Rust::GrustAscii;

use Data::Dump::Tree;

class Ascii is export {
    has Str $.value;

    method gist {
        $.value
    }
}

package AsciiGrammar is export {

    our role Rules {

        proto token ascii-escape { * }

        token ascii-escape:sym<x> { \\x <oct-digit> <hex-digit> }
        token ascii-escape:sym<n> { \\n }
        token ascii-escape:sym<r> { \\r }
        token ascii-escape:sym<t> { \\t }
        token ascii-escape:sym<s> { \\\\ }
        token ascii-escape:sym<0> { \\0 }

        token ascii-for-char {
            <any-ascii> <?{$/ !~~ /[\' | \\ | \n | \r | \t]/}>
        }

        token ascii-for-string {
            <any-ascii> <?{$/ !~~ /[\" | \\ | $Tokens::Rules::isolated-cr]/}>
        }

        token any-ascii {
            <:ASCII>
        }

        token ascii {
            <any-ascii>
        }
    }

    our role Actions {
        method ascii($/) {
            make Ascii.new(
                value => $/.Str
            )
        }
    }
}

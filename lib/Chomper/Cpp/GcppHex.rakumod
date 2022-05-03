unit module Chomper::Cpp::GcppHex;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;

class HexadecimalLiteral is export {
    has Str $.value is required; 

    has $.text;

    method name {
        'HexadecimalLiteral'
    }

    method gist(:$treemark=False) {
        $.value
    }
}

class HexadecimalDigit is export { 
    has Str $.value is required; 

    has $.text;

    method name {
        'HexadecimalDigit'
    }

    method gist(:$treemark=False) {
        $.value
    }
}

#--------------------------
our subset Quad of List is export where (HexadecimalLiteral, HexadecimalLiteral, HexadecimalLiteral, HexadecimalLiteral);

#--------------------------
class HexQuad is export { 
    has Quad @.hexadecimaldigit is required;

    has $.text;

    method name {
        'HexQuad'
    }

    method gist(:$treemark=False) {
        @.hexadecimaldigit>>.gist(:$treemark).join("")
    }
}

class HexadecimalEscapeSequence is export {

    has HexadecimalDigit @.digits is required;

    has $.text;

    method name {
        'HexadecimalEscapeSequence'
    }

    method gist(:$treemark=False) {
        @.digits>>.gist(:$treemark).join("")
    }
}

package HexGrammar is export {

    our role Actions {

        # token hexquad { <hexadecimaldigit> ** 4 }
        method hexquad($/) {
            make HexQuad.new(
                hexadecimaldigit => $<hexadecimaldigit>>>.made,
                text             => ~$/,
            )
        }

        # token hexadecimal-literal { [ '0x' || '0X' ] <hexadecimaldigit> [ '\''? <hexadecimaldigit> ]* }
        method hexadecimal-literal($/) {
            make HexadecimalLiteral.new(
                value => ~$/,
            )
        }

        # token hexadecimaldigit { <[ 0 .. 9 ]> }
        method hexadecimaldigit($/) {
            make HexadecimalDigit.new(
                value => ~$/,
            )
        }
    }

    our role Rules {

        token hexquad {
            <hexadecimaldigit> ** 4
        }

        token hexadecimal-literal {
            [ '0x' || '0X' ] <hexadecimaldigit> [ "'"?  <hexadecimaldigit> ]*
        }

        token hexadecimaldigit {
            <[ 0 .. 9 a .. f A .. F ]>
        }
    }
}

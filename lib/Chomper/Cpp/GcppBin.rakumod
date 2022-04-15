unit module Chomper::Cpp::GcppBin;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;

class BinaryLiteral is export { 
    has Str $.value is required; 

    has $.text;

    method gist(:$treemark=False) {
        $.value
    }
}

class Binarydigit is export { 
    has Str $.value is required; 

    has $.text;

    method gist(:$treemark=False) {
        $.value
    }
}

package BinGrammar is export {

    our role Actions {

        # token binary-literal { [ '0b' || '0B' ] <binarydigit> [ '\''? <binarydigit> ]* }
        method binary-literal($/) {
            make BinaryLiteral.new(
                value => ~$/,
            )
        }

        # token binarydigit { <[ 0 1 ]> } 
        method binarydigit($/) {
            make Binarydigit.new(
                value => ~$/,
            )
        }
    }

    our role Rules {

        token binary-literal {
            [ '0b' || '0B' ] <binarydigit> [ '\''?  <binarydigit> ]*
        }

        token binarydigit {
            <[ 0 1 ]>
        }
    }
}

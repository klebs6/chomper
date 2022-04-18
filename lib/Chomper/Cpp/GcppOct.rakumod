unit module Chomper::Cpp::GcppOct;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;

class OctalLiteral is export { 
    has Str $.value is required; 

    method name {
        'OctalLiteral'
    }

    method gist(:$treemark=False) {

        if $treemark { 
            return "N";
        }

        $.value
    }
}

class OctalDigit is export { 

    has Str $.value is required; 

    method name {
        'OctalDigit'
    }

    method gist(:$treemark=False) {
        $.value
    }
}

class OctalEscapeSequence is export {

    has OctalDigit @.digits is required;

    has $.text;

    method name {
        'OctalEscapeSequence'
    }

    method gist(:$treemark=False) {
        @.digits>>.gist(:$treemark).join("")
    }
}

package OctGrammar is export {

    our role Actions {

        # token octal-literal { '0' [ '\''? <octaldigit>]* }
        method octal-literal($/) {
            make OctalLiteral.new(
                value => ~$/,
            )
        }

        # token octaldigit { <[ 0 .. 7 ]> }
        method octaldigit($/) {
            make OctalDigit.new(
                value => ~$/,
            )
        }
    }

    our role Rules {

        token octal-literal {
            '0' [ '\''?  <octaldigit>]*
        }

        token octaldigit {
            <[ 0 .. 7 ]>
        }
    }
}

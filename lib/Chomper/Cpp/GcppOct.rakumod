unit module Chomper::Cpp::GcppOct;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;

class OctalLiteral is export { 
    has Str $.value is required; 

    method gist(:$treemark=False) {

        if $treemark { 
            return "N";
        }

        $.value
    }
}

class Octaldigit is export { 
    has Str $.value is required; 

    method gist(:$treemark=False) {
        $.value
    }
}

class Octalescapesequence is export {
    has Octaldigit @.digits is required;

    has $.text;

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
            make Octaldigit.new(
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

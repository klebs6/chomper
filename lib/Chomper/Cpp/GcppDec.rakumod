unit module Chomper::Cpp::GcppDec;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;

class DecimalLiteral is export { 
    has Str $.value is required; 

    has $.text;

    method name {
        'DecimalLiteral'
    }

    method gist(:$treemark=False) {

        if $treemark { 
            return "N";
        }

        $.value
    }
}

package DecGrammar is export {

    our role Actions {

        # token decimal-literal { <nonzerodigit> [ '\''? <digit>]* }
        method decimal-literal($/) {
            make DecimalLiteral.new(
                value => ~$/,
            )
        }
    }

    our role Rules {

        token decimal-literal {
            <nonzerodigit> [ '\''?  <digit>]*
        }
    }
}

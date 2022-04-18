unit module Chomper::Cpp::GcppPure;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;
use Chomper::Cpp::GcppOct;

# rule pure-specifier { 
#   <assign> 
#   <val=octal-literal> 
#   #|{if($val.text.compareTo("0")!=0) throw new InputMismatchException(this); } 
# }
class PureSpecifier is export { 
    has OctalLiteral $.val is required;

    has $.text;

    method name {
        'PureSpecifier'
    }

    method gist(:$treemark=False) {
        " = " ~ $.val.gist(:$treemark)
    }
}

package PureGrammar is export {

    our role Actions {

        # rule pure-specifier { <assign> <val=octal-literal> 
        method pure-specifier($/) {
            make PureSpecifier.new(
                val  => $<val>.made,
                text => ~$/,
            )
        }
    }

    our role Rules {

        rule pure-specifier {
            <assign>
            <val=octal-literal>
            #|{if($val.text.compareTo("0")!=0) throw new InputMismatchException(this); }
        }
    }
}

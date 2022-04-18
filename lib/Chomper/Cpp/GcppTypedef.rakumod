unit module Chomper::Cpp::GcppTypedef;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;
use Chomper::Cpp::GcppIdent;

class TypedefName is export { 
    has Identifier $.identifier is required;

    has $.text;

    method name {
        'TypedefName'
    }

    method gist(:$treemark=False) {
        $.identifier.gist(:$treemark)
    }
}

package TypedefGrammar is export {

    our role Actions {

        method typedef-name($/) {
            make $<identifier>.made
        }
    }

    our role Rules {
        rule typedef-name { 
            <identifier> 
        }
    }
}

unit module Chomper::Cpp::GcppConstructor;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;
use Chomper::Cpp::GcppMemInitializer;

# rule constructor-initializer { 
#   <colon> 
#   <mem-initializer-list> 
# }
class ConstructorInitializer is export { 
    has MemInitializerList $.mem-initializer-list is required;
    has $.text;

    method name {
        'ConstructorInitializer'
    }

    method gist(:$treemark=False) {
        ":" ~ $.mem-initializer-list.gist(:$treemark)
    }
}

package ConstructorGrammar is export {

    our role Actions {

        # rule constructor-initializer { <colon> <mem-initializer-list> }
        method constructor-initializer($/) {
            make ConstructorInitializer.new(
                mem-initializer-list => $<mem-initializer-list>.made,
                text                 => ~$/,
            )
        }
    }

    our role Rules {

        rule constructor-initializer {
            <colon> <mem-initializer-list>
        }
    }
}

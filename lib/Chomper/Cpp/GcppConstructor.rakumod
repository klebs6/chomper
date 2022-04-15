unit module Chomper::Cpp::GcppConstructor;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;
use Chomper::Cpp::GcppMemInitializer;

# rule constructor-initializer { 
#   <colon> 
#   <mem-initializer-list> 
# }
our class ConstructorInitializer { 
    has MemInitializerList $.mem-initializer-list is required;
    has $.text;

    method gist(:$treemark=False) {
        ":" ~ $.mem-initializer-list.gist(:$treemark)
    }
}

our role Constructor::Actions {

    # rule constructor-initializer { <colon> <mem-initializer-list> }
    method constructor-initializer($/) {
        make ConstructorInitializer.new(
            mem-initializer-list => $<mem-initializer-list>.made,
            text                 => ~$/,
        )
    }
}

our role Constructor::Rules {

    rule constructor-initializer {
        <colon> <mem-initializer-list>
    }
}
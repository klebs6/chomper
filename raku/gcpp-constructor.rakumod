use Data::Dump::Tree;

use gcpp-roles;
use gcpp-mem-initializer;

# rule constructor-initializer { 
#   <colon> 
#   <mem-initializer-list> 
# }
our class ConstructorInitializer { 
    has MemInitializerList $.mem-initializer-list is required;
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our role Constructor::Actions {

    # rule constructor-initializer { <colon> <mem-initializer-list> }
    method constructor-initializer($/) {
        make ConstructorInitializer.new(
            mem-initializer-list => $<mem-initializer-list>.made,
        )
    }
}

our role Constructor::Rules {

    rule constructor-initializer {
        <colon> <mem-initializer-list>
    }
}

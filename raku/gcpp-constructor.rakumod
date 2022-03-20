
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


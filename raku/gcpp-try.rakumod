# rule try-block { 
#   <try_> 
#   <compound-statement> 
#   <handler-seq> 
# }
our class TryBlock { 
    has CompoundStatement $.compound-statement is required;
    has HandlerSeq        $.handler-seq        is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule function-try-block { 
#   <try_> 
#   <constructor-initializer>? 
#   <compound-statement> 
#   <handler-seq> 
# }
our class FunctionTryBlock { 
    has ConstructorInitializer $.constructor-initializer;
    has CompoundStatement      $.compound-statement is required;
    has HandlerSeq             $.handler-seq is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

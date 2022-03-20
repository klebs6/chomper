# rule handler-seq { 
#   <handler>+ 
# }
our class HandlerSeq { 
    has Handler @.handlers is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule handler { 
#   <catch> 
#   <.left-paren> 
#   <exception-declaration> 
#   <.right-paren> 
#   <compound-statement> 
# }
our class Handler { 
    has IExceptionDeclaration $.exception-declaration is required;
    has CompoundStatement    $.compound-statement is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}


# rule asm-definition { 
#   <asm> 
#   <.left-paren> 
#   <string-literal> 
#   <.right-paren> 
#   <.semi> 
# } #--------------------
our class AsmDefinition { 
    has IComment      $.comment;
    has StringLiteral $.string-literal is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

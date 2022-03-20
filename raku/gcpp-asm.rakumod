
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

our role Asm::Actions {

    # rule asm-definition { <asm> <.left-paren> <string-literal> <.right-paren> <.semi> } 
    method asm-definition($/) {
        make AsmDefinition.new(
            comment        => $<semi>.made,
            string-literal => $<string-literal>.made,
        )
    }
}

our role Asm::Rules {

    rule asm-definition {
        <asm>
        <left-paren>
        <string-literal>
        <right-paren>
        <semi>
    }
}

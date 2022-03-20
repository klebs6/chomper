# rule selection-statement:sym<if> { 
#   <.if_> 
#   <.left-paren> 
#   <condition> 
#   <.right-paren> 
#   <statement> 
#   [ <comment>? <else_> <statement> ]? 
# }
our class SelectionStatement::If 
does IAttributedStatementBody 
does ISelectionStatement {
    has ICondition  $.condition is required;
    has IStatement  @.statements is required;
    has IComment    $.else-statement-comment;
    has IStatement  @.else-statements;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule selection-statement:sym<switch> { 
#   <switch> 
#   <.left-paren> 
#   <condition> 
#   <.right-paren> 
#   <statement> 
# } #-----------------------------
our class SelectionStatement::Switch does ISelectionStatement {
    has ICondition  $.condition is required;
    has IStatement $.statement is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}



# rule iteration-statement:sym<while> { 
#   <while_> 
#   <.left-paren> 
#   <condition> 
#   <.right-paren> <statement> 
# }
our class IterationStatement::While 
does IIterationStatement {

    has ICondition $.condition is required;
    has IStatement @.statements is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule iteration-statement:sym<do> { 
#   <.do_> 
#   <statement> 
#   <.while_> 
#   <.left-paren> 
#   <expression> 
#   <.right-paren> 
#   <.semi> 
# }
our class IterationStatement::Do does IIterationStatement {
    has IComment    $.comment;
    has IStatement  $.statement is required;
    has IExpression $.expression is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule iteration-statement:sym<for> { 
#   <.for_> 
#   <.left-paren> 
#   <for-init-statement> 
#   <condition>? 
#   <semi> 
#   <expression>? 
#   <.right-paren> 
#   <statement> 
# }
our class IterationStatement::For does IIterationStatement {
    has IForInitStatement $.for-init-statement is required;
    has ICondition        $.condition;
    has IExpression       $.expression;
    has IStatement        @.statements is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule iteration-statement:sym<for-range> { 
#   <.for_> 
#   <.left-paren> 
#   <for-range-declaration> 
#   <.colon> 
#   <for-range-initializer> 
#   <.right-paren> 
#   <statement> 
# } #-----------------------------
our class IterationStatement::ForRange does IIterationStatement {
    has ForRangeDeclaration  $.for-range-declaration is required;
    has IForRangeInitializer $.for-range-initializer is required;
    has IStatement           @.statements is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

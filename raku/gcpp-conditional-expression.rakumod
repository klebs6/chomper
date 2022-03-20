# rule conditional-expression-tail { 
#   <question> 
#   <expression> 
#   <colon> 
#   <assignment-expression> 
# }
our class ConditionalExpressionTail {
    has IExpression           $.question-expression   is required;
    has IAssignmentExpression $.assignment-expression is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule conditional-expression { 
#   <logical-or-expression> 
#   <conditional-expression-tail>? 
# }
our class ConditionalExpression does IMultiplicativeExpression does IConditionalExpression {
    has ILogicalOrExpression      $.logical-or-expression is required;
    has ConditionalExpressionTail $.conditional-expression-tail;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}



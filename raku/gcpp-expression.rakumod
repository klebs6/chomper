# rule expression { <assignment-expression>+ %% <.comma> }
our class Expression 
does IExpression 
does IForRangeInitializer 
does ICondition { 

    has IAssignmentExpression @.assignment-expressions is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule constant-expression { <conditional-expression> }
our class ConstantExpression does IConstantExpression {
    has IConditionalExpression $.conditional-expression is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule expression-list { <initializer-list> }
our class ExpressionList does IPostfixExpressionTail { 
    has InitializerList $.initializer-list is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}


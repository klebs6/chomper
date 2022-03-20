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

our role Expression::Actions {

    # rule expression-list { <initializer-list> } 
    method expression-list($/) {
        make $<initializer-list>.made
    }

    # rule expression { <assignment-expression>+ %% <.comma> }
    method expression($/) {
        my @exprs = $<assignment-expression>>>.made;

        if @exprs.elems gt 1 {
            make Expression.new(
                assignment-expressions => @exprs,
            )
        } else {
            make @exprs[0]
        }
    }

    # rule constant-expression { <conditional-expression> }
    method constant-expression($/) {
        make $<conditional-expression>.made
    }
}

our role Expression::Rules {

    rule expression-list {
        <initializer-list>
    }

    rule expression {
        <assignment-expression>+ %% <comma>
    }

    rule constant-expression { 
        <conditional-expression> 
    }

    rule expression-statement {
        <expression>? <semi>
    }
}

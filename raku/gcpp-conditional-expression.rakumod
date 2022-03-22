use Data::Dump::Tree;

use gcpp-roles;

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
        "? " ~ $.expression.gist ~ ": " ~ $.assignment-expression.gist
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

        my $builder = $.logical-or-expression.gist;

        my $t = $.conditional-expression-tail;

        if $t {
            $builder ~= " " ~ $t.gist;
        }

        $builder
    }
}

our role ConditionalExpression::Actions {

    # rule conditional-expression-tail { <question> <expression> <colon> <assignment-expression> }
    method conditional-expression-tail($/) {
        make ConditionalExpressionTail.new(
            question-expression   => $<expression>.made,
            assignment-expression => $<assignment-expression>.made,
        )
    }

    # rule conditional-expression { <logical-or-expression> <conditional-expression-tail>? } 
    method conditional-expression($/) {

        my $base = $<logical-or-expression>.made;
        my $tail = $<conditional-expression-tail>.made;

        if $tail {

            make ConditionalExpression.new(
                logical-or-expression       => $base,
                conditional-expression-tail => $tail,
            )

        } else {

            make $base
        }
    }
}

our role ConditionalExpression::Rules {

    rule conditional-expression-tail {
        <question> 
        <expression> 
        <colon> 
        <assignment-expression> 
    }

    rule conditional-expression {
        <logical-or-expression>
        <conditional-expression-tail>?
    }
}

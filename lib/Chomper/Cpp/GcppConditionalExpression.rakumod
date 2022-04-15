unit module Chomper::Cpp::GcppConditionalExpression;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;

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

    method gist(:$treemark=False) {
        "? " ~ $.question-expression.gist(:$treemark) ~ ": " ~ $.assignment-expression.gist(:$treemark)
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

    method gist(:$treemark=False) {


        my $builder = $.logical-or-expression.gist(:$treemark);

        my $t = $.conditional-expression-tail;

        if $t {
            $builder ~= " " ~ $t.gist(:$treemark);
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
            text                  => ~$/,
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
                text                        => ~$/,
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
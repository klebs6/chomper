use Data::Dump::Tree;

use gcpp-roles;

# token equality-operator:sym<eq> { <equal> }
our class EqualityOperator::Eq does IEqualityOperator {

    has $.text;

    method gist{
        "=="
    }
}

# token equality-operator:sym<neq> { <not-equal> }
our class EqualityOperator::Neq does IEqualityOperator {

    has $.text;

    method gist{
        "!="
    }
}

# rule equality-expression-tail { 
#   <equality-operator> 
#   <relational-expression> 
# }
our class EqualityExpressionTail {
    has IEqualityOperator     $.equality-operator     is required;
    has IRelationalExpression $.relational-expression is required;

    has $.text;

    method gist{
        $.equality-operator.gist 
        ~ " " 
        ~ $.relational-expression.gist
    }
}

# rule equality-expression { 
#   <relational-expression> 
#   <equality-expression-tail>* 
# }
our class EqualityExpression does IEqualityExpression {
    has IRelationalExpression  $.relational-expression is required;
    has EqualityExpressionTail @.equality-expression-tail;

    has $.text;

    method gist{
        $.relational-expression.gist
        ~ @.equality-expression-tail>>.gist.join(" ")
    }
}

our role EqualityExpression::Actions {

    # token equality-operator:sym<eq> { <equal> }
    method equality-operator:sym<eq>($/) {
        make EqualityOperator::Eq.new
    }

    # token equality-operator:sym<neq> { <not-equal> } 
    method equality-operator:sym<neq>($/) {
        make EqualityOperator::Neq.new
    }

    # rule equality-expression-tail { <equality-operator> <relational-expression> }
    method equality-expression-tail($/) {
        make EqualityExpressionTail.new(
            equality-operator     => $<equality-operator>.made,
            relational-expression => $<relational-expression>.made,
            text                  => ~$/,
        )
    }

    # rule equality-expression { <relational-expression> <equality-expression-tail>* }
    method equality-expression($/) {
        my $base = $<relational-expression>.made;
        my @tail = $<equality-expression-tail>>>.made.List;

        if @tail.elems gt 0 {
            make EqualityExpression.new(
                relational-expression    => $base,
                equality-expression-tail => @tail,
                text                     => ~$/,
            )
        } else {
            make $base
        }
    }
}

our role EqualityExpression::Rules {

    proto token equality-operator { * }
    token equality-operator:sym<eq>  { <equal> }
    token equality-operator:sym<neq> { <not-equal> }

    rule equality-expression-tail {
        <equality-operator> 
        <relational-expression>
    }

    rule equality-expression {
        <relational-expression>
        <equality-expression-tail>*
    }
}

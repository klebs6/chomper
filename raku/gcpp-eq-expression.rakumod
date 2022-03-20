
# token equality-operator:sym<eq> { <equal> }
our class EqualityOperator::Eq does IEqualityOperator {

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token equality-operator:sym<neq> { <not-equal> }
our class EqualityOperator::Neq does IEqualityOperator {

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
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
        say "need write gist!";
        ddt self;
        exit;
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
        say "need write gist!";
        ddt self;
        exit;
    }
}

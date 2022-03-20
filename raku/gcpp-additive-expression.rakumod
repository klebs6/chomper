
# token additive-operator:sym<plus> { <plus> }
our class AdditiveOperator::Plus does IAdditiveOperator {

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token additive-operator:sym<minus> { <minus> }
our class AdditiveOperator::Minus does IAdditiveOperator {

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule additive-expression-tail { 
#   <additive-operator> 
#   <multiplicative-expression> 
# }
our class AdditiveExpressionTail {
    has IAdditiveOperator        $.additive-operator         is required;
    has IMultiplicativeExpression $.multiplicative-expression is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule additive-expression { 
#   <multiplicative-expression> 
#   <additive-expression-tail>* 
# }
our class AdditiveExpression does IAdditiveExpression {
    has IMultiplicativeExpression $.multiplicative-expression is required;
    has AdditiveExpressionTail   @.additive-expression-tail;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

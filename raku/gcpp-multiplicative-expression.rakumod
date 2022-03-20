# token multiplicative-operator:sym<*> { <star> }
our class MultiplicativeOperator::Star does IMultiplicativeOperator {

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token multiplicative-operator:sym</> { <div_> }
our class MultiplicativeOperator::Slash does IMultiplicativeOperator {

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token multiplicative-operator:sym<%> { <mod_> }
our class MultiplicativeOperator::Mod does IMultiplicativeOperator {

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule multiplicative-expression { 
#   <pointer-member-expression> 
#   <multiplicative-expression-tail>* 
# }
our class MultiplicativeExpression does IMultiplicativeExpression {
    has IPointerMemberExpression     $.pointer-member-expression is required;
    has MultiplicativeExpressionTail @.multiplicative-expression-tail is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule multiplicative-expression-tail { 
#   <multiplicative-operator> 
#   <pointer-member-expression> 
# }
our class MultiplicativeExpressionTail {
    has IMultiplicativeOperator  $.multiplicative-operator is required;
    has IPointerMemberExpression $.pointer-member-expression is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

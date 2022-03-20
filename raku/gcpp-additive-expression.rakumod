
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

our role AdditiveExpression::Actions {

    # token additive-operator:sym<plus> { <plus> }
    method additive-operator:sym<plus>($/) {
        make AdditiveOperator::Plus.new
    }

    # token additive-operator:sym<minus> { <minus> } 
    method additive-operator:sym<minus>($/) {
        make AdditiveOperator::Minus.new
    }

    # rule additive-expression-tail { <additive-operator> <multiplicative-expression> }
    method additive-expression-tail($/) {
        make AdditiveExpressionTail.new(
            additive-operator         => $<additive-operator>.made,
            multiplicative-expression => $<multiplicative-expression>.made,
        )
    }

    # rule additive-expression { <multiplicative-expression> <additive-expression-tail>* }
    method additive-expression($/) {
        my $base = $<multiplicative-expression>.made;
        my @tail = $<additive-expression-tail>>>.made.List;

        if @tail.elems gt 0 {
            make AdditiveExpression.new(
                multiplicative-expression => $base,
                additive-expression-tail  => @tail,
            )

        } else {
            make $base
        }
    }
}

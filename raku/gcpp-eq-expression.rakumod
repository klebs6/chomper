
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
            )
        } else {
            make $base
        }
    }
}

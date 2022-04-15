unit module Chomper::Cpp::GcppMultiplicativeExpression;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;

our class MultiplicativeExpressionTail { ... }

# token multiplicative-operator:sym<*> { <star> }
our class MultiplicativeOperator::Star does IMultiplicativeOperator {

    has $.text;

    method gist(:$treemark=False) {
        "*"
    }
}

# token multiplicative-operator:sym</> { <div_> }
our class MultiplicativeOperator::Slash does IMultiplicativeOperator {

    has $.text;

    method gist(:$treemark=False) {
        "/"
    }
}

# token multiplicative-operator:sym<%> { <mod_> }
our class MultiplicativeOperator::Mod does IMultiplicativeOperator {

    has $.text;

    method gist(:$treemark=False) {
        "%"
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

    method gist(:$treemark=False) {
        my $b = $.pointer-member-expression;
        my @t = @.multiplicative-expression-tail;

        my $buffer = $b.gist(:$treemark);

        for @t {
            $buffer ~= " " ~ $_.gist(:$treemark);
        }

        $buffer
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

    method gist(:$treemark=False) {
        $.multiplicative-operator.gist(:$treemark) 
        ~ " " 
        ~ $.pointer-member-expression.gist(:$treemark)
    }
}

our role MultiplicativeExpression::Actions {

    # token multiplicative-operator:sym<*> { <star> }
    method multiplicative-operator:sym<*>($/) {
        make MultiplicativeOperator::Star.new
    }

    # token multiplicative-operator:sym</> { <div_> }
    method multiplicative-operator:sym</>($/) {
        make MultiplicativeOperator::Slash.new
    }

    # token multiplicative-operator:sym<%> { <mod_> }
    method multiplicative-operator:sym<%>($/) {
        make MultiplicativeOperator::Mod.new
    }

    # rule multiplicative-expression { <pointer-member-expression> <multiplicative-expression-tail>* }
    method multiplicative-expression($/) {
        my $base = $<pointer-member-expression>.made;
        my @tail = $<multiplicative-expression-tail>>>.made.List;

        if @tail.elems gt 0 {
            make MultiplicativeExpression.new(
                pointer-member-expression      => $base,
                multiplicative-expression-tail => @tail,
                text                           => ~$/,
            )
        } else {
            make $base
        }
    }

    # rule multiplicative-expression-tail { <multiplicative-operator> <pointer-member-expression> } 
    method multiplicative-expression-tail($/) {
        make MultiplicativeExpressionTail.new(
            multiplicative-operator   => $<multiplicative-operator>.made,
            pointer-member-expression => $<pointer-member-expression>.made,
            text                      => ~$/,
        )
    }
}

our role MultiplicativeExpression::Rules {

    proto token multiplicative-operator { * }
    token multiplicative-operator:sym<*> { <star> }
    token multiplicative-operator:sym</> { <div_> }
    token multiplicative-operator:sym<%> { <mod_> }

    rule multiplicative-expression {
        <pointer-member-expression>
        <multiplicative-expression-tail>*
    }

    rule multiplicative-expression-tail {
        <multiplicative-operator> 
        <pointer-member-expression>
    }
}
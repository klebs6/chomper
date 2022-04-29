unit module Chomper::Cpp::GcppAdditiveExpression;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;

package AdditiveOperator is export {

    # token additive-operator:sym<plus> { <plus> }
    our class Plus does IAdditiveOperator {

        has $.text;

        method name {
            'AdditiveOperator::Plus'
        }

        method gist(:$treemark=False) {
            "+"
        }
    }

    # token additive-operator:sym<minus> { <minus> }
    our class Minus does IAdditiveOperator {

        has $.text;

        method name {
            'AdditiveOperator::Minus'
        }

        method gist(:$treemark=False) {
            "-"
        }
    }
}

# rule additive-expression-tail { 
#   <additive-operator> 
#   <multiplicative-expression> 
# }
class AdditiveExpressionTail is export {
    has IAdditiveOperator         $.additive-operator         is required;
    has IMultiplicativeExpression $.multiplicative-expression is required;

    method name {
        'AdditiveExpressionTail'
    }

    method gist(:$treemark=False) {
        $.additive-operator.gist(:$treemark) ~ " " ~ $.multiplicative-expression.gist(:$treemark)
    }
}

# rule additive-expression { 
#   <multiplicative-expression> 
#   <additive-expression-tail>* 
# }
class AdditiveExpression 
does IConstantExpression
does IAdditiveExpression is export {
    has IMultiplicativeExpression $.multiplicative-expression is required;
    has AdditiveExpressionTail    @.additive-expression-tail;

    method name {
        'AdditiveExpression'
    }

    method gist(:$treemark=False) {
        $.multiplicative-expression.gist(:$treemark) 
        ~ " " 
        ~ @.additive-expression-tail>>.gist(:$treemark).join(" ")
    }
}

package AdditiveExpressionGrammar is export {

    our role Actions {

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
                text                      => ~$/,
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
                    text => ~$/,
                )

            } else {
                make $base
            }
        }
    }

    our role Rules {

        proto token additive-operator { * }
        token additive-operator:sym<plus>  {  <plus> }
        token additive-operator:sym<minus> {  <minus> }

        #-----------------
        rule additive-expression-tail {
            <additive-operator> 
            <multiplicative-expression>
        }

        rule additive-expression {
            <multiplicative-expression>
            <additive-expression-tail>*
        }
    }
}

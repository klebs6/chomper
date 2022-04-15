unit module Chomper::Cpp::GcppAdditiveExpression;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;

# token additive-operator:sym<plus> { <plus> }
class AdditiveOperator::Plus does IAdditiveOperator is export {

    has $.text;

    method gist(:$treemark=False) {
        "+"
    }
}

# token additive-operator:sym<minus> { <minus> }
class AdditiveOperator::Minus does IAdditiveOperator is export {

    has $.text;

    method gist(:$treemark=False) {
        "-"
    }
}

# rule additive-expression-tail { 
#   <additive-operator> 
#   <multiplicative-expression> 
# }
class AdditiveExpressionTail is export {
    has IAdditiveOperator         $.additive-operator         is required;
    has IMultiplicativeExpression $.multiplicative-expression is required;

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

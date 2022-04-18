unit module Chomper::Cpp::GcppEqExpression;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;

package EqualityOperator is export {

    # token equality-operator:sym<eq> { <equal> }
    our class Eq does IEqualityOperator {

        has $.text;

        method name {
            'EqualityOperator::Eq'
        }

        method gist(:$treemark=False) {
            "=="
        }
    }

    # token equality-operator:sym<neq> { <not-equal> }
    our class Neq does IEqualityOperator {

        has $.text;

        method name {
            'EqualityOperator::Neq'
        }

        method gist(:$treemark=False) {
            "!="
        }
    }
}

# rule equality-expression-tail { 
#   <equality-operator> 
#   <relational-expression> 
# }
our class EqualityExpressionTail 
is export {

    has IEqualityOperator     $.equality-operator     is required;
    has IRelationalExpression $.relational-expression is required;

    has $.text;

    method name {
        'EqualityExpressionTail'
    }

    method gist(:$treemark=False) {
        $.equality-operator.gist(:$treemark) 
        ~ " " 
        ~ $.relational-expression.gist(:$treemark)
    }
}

# rule equality-expression { 
#   <relational-expression> 
#   <equality-expression-tail>* 
# }
our class EqualityExpression 
does IEqualityExpression 
is export {

    has IRelationalExpression  $.relational-expression is required;
    has EqualityExpressionTail @.equality-expression-tail;

    has $.text;

    method name {
        'EqualityExpression'
    }

    method gist(:$treemark=False) {

        my $builder = $.relational-expression.gist(:$treemark);

        for @.equality-expression-tail {
            $builder ~= " " ~ $_.gist(:$treemark);
        }

        $builder
    }
}

package EqualityExpressionGrammar is export {

    our role Actions {

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

    our role Rules {

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
}

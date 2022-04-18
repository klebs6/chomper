unit module Chomper::Cpp::GcppShiftExpression;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;

# rule shift-expression-tail { <shift-operator> <additive-expression> }
class ShiftExpressionTail is export {
    has IShiftOperator      $.shift-operator      is required;
    has IAdditiveExpression $.additive-expression is required;

    has $.text;

    method name {
        'ShiftExpressionTail'
    }

    method gist(:$treemark=False) {
        $.shift-operator.gist(:$treemark) ~ " " ~ $.additive-expression.gist(:$treemark)
    }
}

# rule shift-expression { <additive-expression> <shift-expression-tail>* } #-----------------------
class ShiftExpression does IShiftExpression is export {
    has IAdditiveExpression  $.additive-expression is required;
    has ShiftExpressionTail @.shift-expression-tail is required;

    has $.text;

    method name {
        'ShiftExpression'
    }

    method gist(:$treemark=False) {
        $.additive-expression.gist(:$treemark) ~ " " ~ @.shift-expression-tail>>.gist(:$treemark).join(" ")
    }
}

package ShiftOperator is export {

    # rule shift-operator:sym<right> { <.greater> <.greater> }
    class Right does IShiftOperator {

        has $.text;

        method name {
            'ShiftOperator::Right'
        }

        method gist(:$treemark=False) {
            ">>"
        }
    }

    # rule shift-operator:sym<left> { <.less> <.less> } #-----------------------
    class Left does IShiftOperator {

        has $.text;

        method name {
            'ShiftOperator::Left'
        }

        method gist(:$treemark=False) {
            "<<"
        }
    }
}

package ShiftExpressionGrammar is export {

    our role Actions {

        # rule shift-expression-tail { <shift-operator> <additive-expression> }
        method shift-expression-tail($/) {
            make ShiftExpressionTail.new(
                shift-operator      => $<shift-operator>.made,
                additive-expression => $<additive-expression>.made,
                text                => ~$/,
            )
        }

        # rule shift-expression { <additive-expression> <shift-expression-tail>* } 
        method shift-expression($/) {

            my $base = $<additive-expression>.made;
            my @tail = $<shift-expression-tail>>>.made.List;

            if @tail.elems gt 0 {

                make ShiftExpression.new(
                    additive-expression   => $base,
                    shift-expression-tail => @tail,
                    text                  => ~$/,
                )

            } else {

                make $base
            }
        }

        # rule shift-operator:sym<right> { <.greater> <.greater> }
        method shift-operator:sym<right>($/) {
            make ShiftOperator::Right.new
        }

        # rule shift-operator:sym<left> { <.less> <.less> } 
        method shift-operator:sym<left>($/) {
            make ShiftOperator::Left.new
        }
    }

    our role Rules {

        rule shift-expression-tail {
            <shift-operator>
            <additive-expression>
        }

        rule shift-expression {
            <additive-expression>
            <shift-expression-tail>*
        }

        #-----------------------
        proto rule shift-operator { * }
        rule shift-operator:sym<right> { <greater> <greater> }
        rule shift-operator:sym<left>  { <less> <less> }
    }
}

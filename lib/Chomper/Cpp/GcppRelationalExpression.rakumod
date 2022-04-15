unit module Chomper::Cpp::GcppRelationalExpression;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;

# rule relational-operator:sym<less> { <.less> }
class RelationalOperator::Less does IRelationalOperator is export {

    has $.text;

    method gist(:$treemark=False) {
        "<"
    }
}

# rule relational-operator:sym<greater> { <.greater> }
class RelationalOperator::Greater does IRelationalOperator is export {

    has $.text;

    method gist(:$treemark=False) {
        ">"
    }
}

# rule relational-operator:sym<less-eq> { <.less-equal> }
class RelationalOperator::LessEq does IRelationalOperator is export {

    has $.text;

    method gist(:$treemark=False) {
        "<="
    }
}

# rule relational-operator:sym<greater-eq> { <.greater-equal> }
class RelationalOperator::GreaterEq does IRelationalOperator is export {

    has $.text;

    method gist(:$treemark=False) {
        ">="
    }
}

# regex relational-expression-tail { 
#   <.ws> 
#   <relational-operator> 
#   <.ws> 
#   <shift-expression> 
# }
class RelationalExpressionTail is export {
    has IRelationalOperator  $.relational-operator is required;
    has IShiftExpression     $.shift-expression    is required;

    has $.text;

    method gist(:$treemark=False) {
        " " 
        ~ $.relational-operator.gist(:$treemark) 
        ~ " " 
        ~ $.shift-expression.gist(:$treemark)
    }
}

# regex relational-expression { 
#   <shift-expression> 
#   <relational-expression-tail>* 
# }
class RelationalExpression does IRelationalExpression is export {
    has IShiftExpression         $.shift-expression is required;
    has RelationalExpressionTail @.relational-expression-tail;

    has $.text;

    method gist(:$treemark=False) {
        $.shift-expression.gist(:$treemark) 
        ~ " " 
        ~ @.relational-expression-tail>>.gist(:$treemark).join(" ")
    }
}

package RelationalExpressionGrammar is export {

    our role Actions {

        # rule relational-operator:sym<less> { <.less> }
        method relational-operator:sym<less>($/) {
            make RelationalOperator::Less.new
        }

        # rule relational-operator:sym<greater> { <.greater> }
        method relational-operator:sym<greater>($/) {
            make RelationalOperator::Greater.new
        }

        # rule relational-operator:sym<less-eq> { <.less-equal> }
        method relational-operator:sym<less-eq>($/) {
            make RelationalOperator::LessEq.new
        }

        # rule relational-operator:sym<greater-eq> { <.greater-equal> } 
        method relational-operator:sym<greater-eq>($/) {
            make RelationalOperator::GreaterEq.new
        }

        # regex relational-expression-tail { <.ws> <relational-operator> <.ws> <shift-expression> }
        method relational-expression-tail($/) {
            make RelationalExpressionTail.new(
                relational-operator => $<relational-operator>.made,
                shift-expression    => $<shift-expression>.made,
                text                => ~$/,
            )
        }

        # regex relational-expression { <shift-expression> <relational-expression-tail>* } 
        method relational-expression($/) {
            my $base = $<shift-expression>.made;
            my @tail = $<relational-expression-tail>>>.made.List;

            if @tail.elems gt 0 {
                make RelationalExpression.new(
                    shift-expression           => $base,
                    relational-expression-tail => @tail,
                    text                       => ~$/,
                )
            } else {
                make $base
            }
        }
    }

    our role Rules {

        proto rule relational-operator { * }
        rule relational-operator:sym<less>       { <less> }
        rule relational-operator:sym<greater>    { <greater> }
        rule relational-operator:sym<less-eq>    { <less-equal> }
        rule relational-operator:sym<greater-eq> { <greater-equal> }

        #-----------------------
        regex relational-expression-tail {
            <ws>
            <relational-operator>
            <ws>
            <shift-expression>
        }

        regex relational-expression {
            <shift-expression>
            <relational-expression-tail>*
        }
    }
}

use Data::Dump::Tree;

use gcpp-roles;

# rule relational-operator:sym<less> { <.less> }
our class RelationalOperator::Less does IRelationalOperator {

    has $.text;

    method gist{
        "<"
    }
}

# rule relational-operator:sym<greater> { <.greater> }
our class RelationalOperator::Greater does IRelationalOperator {

    has $.text;

    method gist{
        ">"
    }
}

# rule relational-operator:sym<less-eq> { <.less-equal> }
our class RelationalOperator::LessEq does IRelationalOperator {

    has $.text;

    method gist{
        "<="
    }
}

# rule relational-operator:sym<greater-eq> { <.greater-equal> }
our class RelationalOperator::GreaterEq does IRelationalOperator {

    has $.text;

    method gist{
        ">="
    }
}

# regex relational-expression-tail { 
#   <.ws> 
#   <relational-operator> 
#   <.ws> 
#   <shift-expression> 
# }
our class RelationalExpressionTail {
    has IRelationalOperator  $.relational-operator is required;
    has IShiftExpression     $.shift-expression    is required;

    has $.text;

    method gist{
        " " 
        ~ $.relational-operator.gist 
        ~ " " 
        ~ $.shift-expression.gist
    }
}

# regex relational-expression { 
#   <shift-expression> 
#   <relational-expression-tail>* 
# }
our class RelationalExpression does IRelationalExpression {
    has IShiftExpression         $.shift-expression is required;
    has RelationalExpressionTail @.relational-expression-tail;

    has $.text;

    method gist{
        $.shift-expression.gist 
        ~ " " 
        ~ @.relational-expression-tail>>.gist.join(" ")
    }
}

our role RelationalExpression::Actions {

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

our role RelationalExpression::Rules {

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

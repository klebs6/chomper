
# rule shift-expression-tail { <shift-operator> <additive-expression> }
our class ShiftExpressionTail {
    has IShiftOperator      $.shift-operator      is required;
    has IAdditiveExpression $.additive-expression is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule shift-expression { <additive-expression> <shift-expression-tail>* } #-----------------------
our class ShiftExpression does IShiftExpression {
    has IAdditiveExpression  $.additive-expression is required;
    has ShiftExpressionTail @.shift-expression-tail is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule shift-operator:sym<right> { <.greater> <.greater> }
our class ShiftOperator::Right does IShiftOperator {

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule shift-operator:sym<left> { <.less> <.less> } #-----------------------
our class ShiftOperator::Left does IShiftOperator {

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our role ShiftExpression::Actions {

    # rule shift-expression-tail { <shift-operator> <additive-expression> }
    method shift-expression-tail($/) {
        make ShiftExpressionTail.new(
            shift-operator      => $<shift-operator>.made,
            additive-expression => $<additive-expression>.made,
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

our role ShiftExpression::Rules {

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

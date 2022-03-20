# rule logical-and-expression { 
#   <inclusive-or-expression> 
#   [ <and-and> <inclusive-or-expression>]* 
# }
our class LogicalAndExpression does ILogicalAndExpression {
    has IInclusiveOrExpression @.inclusive-or-expressions is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule logical-or-expression { 
#   <logical-and-expression> 
#   [ <or-or> <logical-and-expression> ]* 
# }
our class LogicalOrExpression does ILogicalOrExpression {
    has ILogicalAndExpression @.logical-and-expressions is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our role LogicalExpression::Actions {

    # rule logical-and-expression { <inclusive-or-expression> [ <and-and> <inclusive-or-expression>]* }
    method logical-and-expression($/) {

        my @inclusive-or-expressions = $<inclusive-or-expression>>>.made;

        if @inclusive-or-expressions.elems gt 1 {
            make LogicalAndExpression.new(
                inclusive-or-expressions => @inclusive-or-expressions,
            )
        } else {
            make @inclusive-or-expressions[0]
        }
    }

    # rule logical-or-expression { <logical-and-expression> [ <or-or> <logical-and-expression> ]* }
    method logical-or-expression($/) {

        my @exprs = $<logical-and-expression>>>.made;

        if @exprs.elems gt 1 {
            make LogicalOrExpression.new(
                logical-and-expressions => @exprs,
            )
        } else {
            make @exprs[0]
        }
    }
}

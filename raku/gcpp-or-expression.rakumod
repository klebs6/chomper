# rule exclusive-or-expression { 
#   <and-expression> 
#   [ <caret> <and-expression> ]* 
# }
our class ExclusiveOrExpression does IExclusiveOrExpression {
    has IAndExpression @.and-expressions is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule inclusive-or-expression { 
#   <exclusive-or-expression> 
#   [ <or_> <exclusive-or-expression> ]* 
# }
our class InclusiveOrExpression does IInclusiveOrExpression {
    has IExclusiveOrExpression @.exclusive-or-expressions is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}


our role OrExpression::Actions {

    # rule exclusive-or-expression { 
    #   <and-expression> 
    #   [ <caret> <and-expression> ]* 
    # }
    method exclusive-or-expression($/) {
        my @and-expressions = $<and-expression>>>.made;

        if @and-expressions.elems gt 1 {
            make ExclusiveOrExpression.new(
                and-expressions => @and-expressions,
            )
        } else {
            make @and-expressions[0]
        }
    }

    # rule inclusive-or-expression { 
    #   <exclusive-or-expression> 
    #   [ <or_> <exclusive-or-expression> ]* 
    # }
    method inclusive-or-expression($/) {

        my @exclusive-or-expressions = $<exclusive-or-expression>>>.made;

        if @exclusive-or-expressions.elems gt 1 {
            make InclusiveOrExpression.new(
                exclusive-or-expressions => @exclusive-or-expressions,
            )

        } else {
            make @exclusive-or-expressions[0]
        }
    }
}

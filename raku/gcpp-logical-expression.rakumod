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

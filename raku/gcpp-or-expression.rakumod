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


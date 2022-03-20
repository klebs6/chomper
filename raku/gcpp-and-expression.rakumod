# rule and-expression { 
#   <equality-expression> 
#   [ <and_> <equality-expression> ]* 
# }
our class AndExpression does IAndExpression {
    has IEqualityExpression @.equality-expressions is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

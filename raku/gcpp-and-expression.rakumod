use Data::Dump::Tree;

use gcpp-roles;

# rule and-expression { 
#   <equality-expression> 
#   [ <and_> <equality-expression> ]* 
# }
our class AndExpression does IAndExpression {
    has IEqualityExpression @.equality-expressions is required;

    has $.text;

    method gist{
        @.equality-expressions>>.gist.join(" & ")
    }
}

our role AndExpression::Actions {

    # rule and-expression { <equality-expression> [ <and_> <equality-expression> ]* }
    method and-expression($/) {

        my @equality-expressions = $<equality-expression>>>.made.List;

        if @equality-expressions.elems gt 1 {
            make AndExpression.new(
                equality-expressions => @equality-expressions,
            )

        } else {
            make @equality-expressions[0]
        }
    }
}

our role AndExpression::Rules {

    rule and-expression {
        <equality-expression> [ <and_> <equality-expression> ]*
    }
}

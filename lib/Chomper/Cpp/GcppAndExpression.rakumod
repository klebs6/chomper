unit module Chomper::Cpp::GcppAndExpression;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;

# rule and-expression { 
#   <equality-expression> 
#   [ <and_> <equality-expression> ]* 
# }
class AndExpression does IAndExpression is export {
    has IEqualityExpression @.equality-expressions is required;

    has $.text;

    method gist(:$treemark=False) {
        @.equality-expressions>>.gist(:$treemark).join(" & ")
    }
}

package AndExpressionGrammar is export {

    our role Actions {

        # rule and-expression { <equality-expression> [ <and_> <equality-expression> ]* }
        method and-expression($/) {

            my @equality-expressions = $<equality-expression>>>.made.List;

            if @equality-expressions.elems gt 1 {
                make AndExpression.new(
                    equality-expressions => @equality-expressions,
                    text                 => ~$/,
                )

            } else {
                make @equality-expressions[0]
            }
        }
    }

    our role Rules {

        rule and-expression {
            <equality-expression> [ <and_> <equality-expression> ]*
        }
    }
}

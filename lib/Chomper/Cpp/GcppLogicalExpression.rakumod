unit module Chomper::Cpp::GcppLogicalExpression;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;

# rule logical-and-expression { 
#   <inclusive-or-expression> 
#   [ <and-and> <inclusive-or-expression>]* 
# }
class LogicalAndExpression does ILogicalAndExpression is export {
    has IInclusiveOrExpression @.inclusive-or-expressions is required;

    has $.text;

    method name {
        'LogicalAndExpression'
    }

    method gist(:$treemark=False) {
        @.inclusive-or-expressions>>.gist(:$treemark).join(" && ")
    }
}

# rule logical-or-expression { 
#   <logical-and-expression> 
#   [ <or-or> <logical-and-expression> ]* 
# }
class LogicalOrExpression does ILogicalOrExpression is export {
    has ILogicalAndExpression @.logical-and-expressions is required;

    has $.text;

    method name {
        'LogicalOrExpression'
    }

    method gist(:$treemark=False) {
        @.logical-and-expressions>>.gist(:$treemark).join(" || ")
    }
}

package LogicalExpressionGrammar is export {

    our role Actions {

        # rule logical-and-expression { <inclusive-or-expression> [ <and-and> <inclusive-or-expression>]* }
        method logical-and-expression($/) {

            my @inclusive-or-expressions = $<inclusive-or-expression>>>.made;

            if @inclusive-or-expressions.elems gt 1 {
                make LogicalAndExpression.new(
                    inclusive-or-expressions => @inclusive-or-expressions,
                    text                     => ~$/,
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
                    text                    => ~$/,
                )
            } else {
                make @exprs[0]
            }
        }
    }

    our role Rules {

        rule logical-and-expression {
            <inclusive-or-expression> [ <and-and> <inclusive-or-expression>]*
        }

        rule logical-or-expression {
            <logical-and-expression> [ <or-or> <logical-and-expression> ]*
        }
    }
}

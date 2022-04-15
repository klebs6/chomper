unit module Chomper::Cpp::GcppNoexcept;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;

# token noe-except-specification:sym<full> { 
#   <noexcept> 
#   <.left-paren> 
#   <constant-expression> 
#   <.right-paren> 
# }
class NoeExceptSpecification::Full 
does INoeExceptSpecification is export {
    has IConstantExpression $.constant-expression is required;

    has $.text;

    method gist(:$treemark=False) {
        "noexcept(" ~ $.constant-expression.gist(:$treemark) ~ ")"
    }
}

# token noe-except-specification:sym<keyword-only> { 
#   <noexcept> 
# }
class NoeExceptSpecification::KeywordOnly 
does INoeExceptSpecification is export { 

    has $.text;

    method gist(:$treemark=False) {
        "noexcept"
    }
}

# rule no-except-expression { 
#   <noexcept> 
#   <.left-paren> 
#   <expression> 
#   <.right-paren> 
# }
class NoExceptExpression is export { 
    has IExpression $.expression is required;

    has $.text;

    method gist(:$treemark=False) {
        "noexcept(" ~ $.expression.gist(:$treemark) ~ ")"
    }
}

package NoExceptExpressionGrammar is export {

    our role Actions {

        # rule no-except-expression { 
        #   <noexcept> 
        #   <.left-paren> 
        #   <expression> 
        #   <.right-paren> 
        # }
        method no-except-expression($/) {
            make NoExceptExpression.new(
                expression => $<expression>.made,
                text       => ~$/,
            )
        }

        # token noe-except-specification:sym<full> { 
        #   <noexcept> 
        #   <.left-paren> 
        #   <constant-expression> 
        #   <.right-paren> 
        # }
        method noe-except-specification:sym<full>($/) {
            make NoeExceptSpecification::Full.new(
                constant-expression => $<constant-expression>.made,
                text                => ~$/,
            )
        }

        # token noe-except-specification:sym<keyword-only> { 
        #   <noexcept> 
        # }
        method noe-except-specification:sym<keyword-only>($/) {
            make NoeExceptSpecification::KeywordOnly.new
        }
    }

    our role Rules {

        rule no-except-expression {
            <noexcept>
            <left-paren>
            <expression>
            <right-paren>
        }

        proto token noe-except-specification { * }

        token noe-except-specification:sym<full> { 
            <noexcept> 
            <left-paren> 
            <constant-expression> 
            <right-paren> 
        }

        token noe-except-specification:sym<keyword-only> { 
            <noexcept> 
        }
    }
}

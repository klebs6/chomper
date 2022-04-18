unit module Chomper::Cpp::GcppNoexcept;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;

package NoExceptSpecification is export {

    # token no-except-specification:sym<full> { 
    #   <noexcept> 
    #   <.left-paren> 
    #   <constant-expression> 
    #   <.right-paren> 
    # }
    class Full does INoExceptSpecification {

        has IConstantExpression $.constant-expression is required;

        has $.text;

        method name {
            'NoExceptSpecification::Full'
        }

        method gist(:$treemark=False) {
            "noexcept(" ~ $.constant-expression.gist(:$treemark) ~ ")"
        }
    }

    # token no-except-specification:sym<keyword-only> { 
    #   <noexcept> 
    # }
    class KeywordOnly does INoExceptSpecification { 

        has $.text;

        method name {
            'NoExceptSpecification::KeywordOnly'
        }

        method gist(:$treemark=False) {
            "noexcept"
        }
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

    method name {
        'NoExceptExpression'
    }

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

        # token no-except-specification:sym<full> { 
        #   <noexcept> 
        #   <.left-paren> 
        #   <constant-expression> 
        #   <.right-paren> 
        # }
        method no-except-specification:sym<full>($/) {
            make NoExceptSpecification::Full.new(
                constant-expression => $<constant-expression>.made,
                text                => ~$/,
            )
        }

        # token no-except-specification:sym<keyword-only> { 
        #   <noexcept> 
        # }
        method no-except-specification:sym<keyword-only>($/) {
            make NoExceptSpecification::KeywordOnly.new
        }
    }

    our role Rules {

        rule no-except-expression {
            <noexcept>
            <left-paren>
            <expression>
            <right-paren>
        }

        proto token no-except-specification { * }

        token no-except-specification:sym<full> { 
            <noexcept> 
            <left-paren> 
            <constant-expression> 
            <right-paren> 
        }

        token no-except-specification:sym<keyword-only> { 
            <noexcept> 
        }
    }
}

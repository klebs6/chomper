unit module Chomper::Cpp::GcppDecltype;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;

package DecltypeSpecifierBody is export {

    # rule decltype-specifier-body:sym<expr> { 
    #   <expression> 
    # }
    our class Expr does IDecltypeSpecifierBody {
        has IExpression $.expression is required;

        has $.text;

        method name {
            'DecltypeSpecifierBody::Expr'
        }

        method gist(:$treemark=False) {
            $.expression.gist(:$treemark)
        }
    }

    # rule decltype-specifier-body:sym<auto> { 
    #   <auto> 
    # }
    our class Auto does IDecltypeSpecifierBody {

        has $.text;

        method name {
            'DecltypeSpecifierBody::Auto'
        }

        method gist(:$treemark=False) {
            "auto"
        }
    }
}

# rule decltype-specifier { 
#   <decltype> 
#   <.left-paren> 
#   <decltype-specifier-body> 
#   <.right-paren> 
# }
class DecltypeSpecifier is export { 
    has IDecltypeSpecifierBody $.decltype-specifier-body is required;

    has $.text;

    method name {
        'DecltypeSpecifier'
    }

    method gist(:$treemark=False) {
        "decltype(" ~ $.decltype-specifier-body.gist(:$treemark) ~ ")"
    }
}

package DecltypeGrammar is export {

    our role Actions {

        # rule decltype-specifier-body:sym<expr> { <expression> }
        method decltype-specifier-body:sym<expr>($/) {
            make $<expression>.made
        }

        # rule decltype-specifier-body:sym<auto> { <auto> }
        method decltype-specifier-body:sym<auto>($/) {
            make DecltypeSpecifierBody::Auto.new
        }

        # rule decltype-specifier { <decltype> <.left-paren> <decltype-specifier-body> <.right-paren> } 
        method decltype-specifier($/) {
            make DecltypeSpecifier.new(
                decltype-specifier-body => $<decltype-specifier-body>.made,
                text                    => ~$/,
            )
        }
    }
}

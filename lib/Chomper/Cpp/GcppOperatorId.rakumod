unit module Chomper::Cpp::GcppOperatorId;

use Data::Dump::Tree;

use Chomper::Cpp::GcppStr;
use Chomper::Cpp::GcppRoles;
use Chomper::Cpp::GcppIdent;
use Chomper::Cpp::GcppUserDefinedLiteral;

# rule operator-function-id { 
#   <operator> 
#   <the-operator> 
# }
class OperatorFunctionId is export { 
    has ITheOperator $.the-operator is required;
    has $.text;

    method name {
        'OperatorFunctionId'
    }

    method gist(:$treemark=False) {
        "operator " ~ $.the-operator.gist(:$treemark)
    }
}


package LiteralOperatorId is export {

    # rule literal-operator-id:sym<string-lit> { <operator> <string-literal> <identifier> }
    class StringLit does ILiteralOperatorId {

        has StringLiteral $.string-literal is required;
        has Identifier    $.identifier     is required;
        has $.text;

        method name {
            'LiteralOperatorId::StringLit'
        }

        method gist(:$treemark=False) {
            "operator " ~ $.string-literal.gist(:$treemark) ~ $.identifier.gist(:$treemark)
        }
    }

    # rule literal-operator-id:sym<user-defined> { 
    #   <operator> 
    #   <user-defined-string-literal> 
    # }
    class UserDefined does ILiteralOperatorId {

        has UserDefinedStringLiteral $.user-defined-string-literal is required;
        has $.text;

        method name {
            'LiteralOperatorId::UserDefined'
        }

        method gist(:$treemark=False) {
            "operator " ~ $.user-defined-string-literal.gist(:$treemark)
        }
    }
}

package OperatorIdGrammar is export {

    our role Actions {

        # rule operator-function-id { <operator> <the-operator> } 
        method operator-function-id($/) {
            make OperatorFunctionId.new(
                the-operator => $<the-operator>.made,
                text         => ~$/,
            )
        }

        # rule literal-operator-id:sym<string-lit> { <operator> <string-literal> <identifier> }
        method literal-operator-id:sym<string-lit>($/) {
            make LiteralOperatorId::StringLit.new(
                string-literal => $<string-literal>.made,
                identifier     => $<identifier>.made,
                text           => ~$/,
            )
        }

        # rule literal-operator-id:sym<user-defined> { <operator> <user-defined-string-literal> } 
        method literal-operator-id:sym<user-defined>($/) {
            make LiteralOperatorId::UserDefined.new(
                user-defined-string-literal => $<user-defined-string-literal>.made,
                text                        => ~$/,
            )
        }
    }

    our role Rules {

        rule operator-function-id {
            <operator> <the-operator>
        }

        proto rule literal-operator-id { * }

        rule literal-operator-id:sym<string-lit> {
            <operator>
            <string-literal> 
            <identifier>
        }

        rule literal-operator-id:sym<user-defined> {
            <operator>
            <user-defined-string-literal>
        }
    }
}

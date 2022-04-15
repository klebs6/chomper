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
our class OperatorFunctionId { 
    has ITheOperator $.the-operator is required;
    has $.text;

    method gist(:$treemark=False) {
        "operator " ~ $.the-operator.gist(:$treemark)
    }
}


# rule literal-operator-id:sym<string-lit> { <operator> <string-literal> <identifier> }
our class LiteralOperatorId::StringLit does ILiteralOperatorId {
    has StringLiteral $.string-literal is required;
    has Identifier    $.identifier     is required;
    has $.text;

    method gist(:$treemark=False) {
        "operator " ~ $.string-literal.gist(:$treemark) ~ $.identifier.gist(:$treemark)
    }
}

# rule literal-operator-id:sym<user-defined> { 
#   <operator> 
#   <user-defined-string-literal> 
# }
our class LiteralOperatorId::UserDefined does ILiteralOperatorId {
    has UserDefinedStringLiteral $.user-defined-string-literal is required;
    has $.text;

    method gist(:$treemark=False) {
        "operator " ~ $.user-defined-string-literal.gist(:$treemark)
    }
}

our role OperatorId::Actions {

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

our role OperatorId::Rules {

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
# rule operator-function-id { 
#   <operator> 
#   <the-operator> 
# }
our class OperatorFunctionId { 
    has ITheOperator $.the-operator is required;
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}


# rule literal-operator-id:sym<string-lit> { <operator> <string-literal> <identifier> }
our class LiteralOperatorId::StringLit does ILiteralOperatorId {
    has StringLiteral $.string-literal is required;
    has Identifier    $.identifier     is required;
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule literal-operator-id:sym<user-defined> { 
#   <operator> 
#   <user-defined-string-literal> 
# }
our class LiteralOperatorId::UserDefined does ILiteralOperatorId {
    has UserDefinedStringLiteral $.user-defined-string-literal is required;
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}


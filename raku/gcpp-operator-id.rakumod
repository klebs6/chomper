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

our role OperatorId::Actions {

    # rule operator-function-id { <operator> <the-operator> } 
    method operator-function-id($/) {
        make OperatorFunctionId.new(
            the-operator => $<the-operator>.made,
        )
    }

    # rule literal-operator-id:sym<string-lit> { <operator> <string-literal> <identifier> }
    method literal-operator-id:sym<string-lit>($/) {
        make LiteralOperatorId::StringLit.new(
            string-literal => $<string-literal>.made,
            identifier     => $<identifier>.made,
        )
    }

    # rule literal-operator-id:sym<user-defined> { <operator> <user-defined-string-literal> } 
    method literal-operator-id:sym<user-defined>($/) {
        make LiteralOperatorId::UserDefined.new(
            user-defined-string-literal => $<user-defined-string-literal>.made,
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

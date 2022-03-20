
# rule return-statement-body:sym<expr> { <expression> }
our class ReturnStatementBody::Expr does IReturnStatementBody {
    has IExpression $.expression is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule return-statement-body:sym<braced-init-list> { <braced-init-list> }
our class ReturnStatementBody::BracedInitList does IReturnStatementBody {
    has BracedInitList $.braced-init-list is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}



use Data::Dump::Tree;

use gcpp-roles;
use gcpp-expression;

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

our role ReturnStatement::Actions {

    # rule return-statement-body:sym<expr> { <expression> }
    method return-statement-body:sym<expr>($/) {
        make $<expression>.made
    }

    # rule return-statement-body:sym<braced-init-list> { <braced-init-list> }
    method return-statement-body:sym<braced-init-list>($/) {
        make $<braced-init-list>.made
    }
}

our role ReturnStatement::Rules {

    proto rule return-statement-body { * }
    rule return-statement-body:sym<expr> { <expression> }
    rule return-statement-body:sym<braced-init-list> { <braced-init-list> }
}

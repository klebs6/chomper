unit module Chomper::Cpp::GcppReturnStatement;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;
use Chomper::Cpp::GcppExpression;

package ReturnStatementBody is export {

    # rule return-statement-body:sym<expr> { <expression> }
    our class Expr does IReturnStatementBody {
        has IExpression $.expression is required;

        has $.text;

        method name {
            'ReturnStatementBody::Expr'
        }

        method gist(:$treemark=False) {
            say "need write gist!";
            ddt self;
            exit;
        }
    }

    # rule return-statement-body:sym<braced-init-list> { <braced-init-list> }
    our class BracedInitList does IReturnStatementBody {
        has BracedInitList $.braced-init-list is required;

        has $.text;

        method name {
            'ReturnStatementBody::BracedInitList'
        }

        method gist(:$treemark=False) {
            say "need write gist!";
            ddt self;
            exit;
        }
    }
}

package ReturnStatementGrammar is export {

    our role Actions {

        # rule return-statement-body:sym<expr> { <expression> }
        method return-statement-body:sym<expr>($/) {
            make $<expression>.made
        }

        # rule return-statement-body:sym<braced-init-list> { <braced-init-list> }
        method return-statement-body:sym<braced-init-list>($/) {
            make $<braced-init-list>.made
        }
    }

    our role Rules {

        proto rule return-statement-body { * }
        rule return-statement-body:sym<expr> { <expression> }
        rule return-statement-body:sym<braced-init-list> { <braced-init-list> }
    }
}

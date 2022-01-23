use Grammar::Tracer;

use gpython-keywords;
use gpython-decorators;
use gpython-input;
use gpython-test;
use gpython-stmt;
use gpython-imports;
use gpython-expr;
use gpython-error;
use gpython-dictorset;
use gpython-yield;
use gpython-string;
use gpython-bytes;
use gpython-varargs;
use gpython-id;
use gpython-integer;
use gpython-float;
use gpython-literal;
use gpython-arg;
use gpython-newline;

class NEW_INDENTATION { }

grammar Python3 
does Python3Keywords 
does Python3Input
does Python3Stmt
does Python3Test
does Python3Imports
does Python3Expr
does Python3YieldExpr
does Python3DictOrSet
does Python3Literal
does Python3Arg
does Python3Newline
does Python3Decorators 
{
    token enter_scope { <?> }
    token leave_scope { <?> }

    rule TOP {
        :my @*INDENTATION = (0,);
        :my $*opened = 0;

        <.enter_scope>
        <file_input>
        $

        # leave all open scopes:
        { self.handle-indentation('') }
        <.leave_scope>
    }

    token ws { \h* }

    token suite {
        | <simple_stmt>
        | <NEWLINE> <INDENT> <stmt>+ <DEDENT>
    }

    token UNKNOWN_CHAR {
        .
    }

    token SPACES {
        <[   \t ]>+
    }

    token COMMENT {
        '#' <-[ \r \n ]>*
    }

    token LINE_JOINING {
        '\\' <SPACES>?  [ '\r'?  '\n' | '\r']
    }
}

use Data::Dump::Tree;

use gcpp-roles;

our class Not::Bang does INot { 

    has $.text;

    method gist(:$treemark=False) { 
        "!"
    }
}

our class Not::Not does INot { 

    has $.text;

    method gist(:$treemark=False) { 
        "!"
    }
}

our class AndAnd::AndAnd does IAndAnd { 

    has $.text;

    method gist(:$treemark=False) {
        "&&"
    }
}

our class AndAnd::And does IAndAnd { 

    has $.text;

    method gist(:$treemark=False) {
        "&"
    }
}

our class OrOr::PipePipe does IOrOr { 

    has $.text;

    method gist(:$treemark=False) {
        "||"
    }
}

our class OrOr::Or does IOrOr { 

    has $.text;

    method gist(:$treemark=False) {
        "|"
    }
}

our role Token::Rules {

    token whitespace {
        <[   \t ]>+
    }

    token newline_ {
        [   
            ||  '\r' '\n'?
            ||  '\n'
        ]
    }
}

our class Not::Bang does INot { 

    has $.text;

    method gist { 
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Not::Not does INot { 

    has $.text;

    method gist { 
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class AndAnd::AndAnd does IAndAnd { 

    has $.text;

    method gist {

    }
}

our class AndAnd::And does IAndAnd { 

    has $.text;

    method gist {

    }
}

our class OrOr::PipePipe does IOrOr { 

    has $.text;

    method gist {

    }
}

our class OrOr::Or does IOrOr { 

    has $.text;

    method gist {

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

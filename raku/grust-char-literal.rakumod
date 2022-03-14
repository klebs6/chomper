our class CharLiteral {
    has $.value;

    has $.text;

    submethod TWEAK {
        say self.gist;
    }

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our role CharLiteral::Rules {

    proto token char-literal-body { * }

    token char-literal-body:sym<not-forbidden> { 
        <-[\' \\ \n \r \t ]>
    }

    token char-literal-body:sym<quote-escape> { 
        <quote-escape>
    }

    token char-literal-body:sym<ascii-escape> { 
        <ascii-escape>
    }

    token char-literal-body:sym<unicode-escape> { 
        <unicode-escape>
    }

    token char-literal {
        <tok-single-quote>
        <char-literal-body>
        <tok-single-quote>
    }
}

our role CharLiteral::Actions {
    method char-literal($/) {
        make CharLiteral.new(
            value => $/.Str,
        )
    }
}

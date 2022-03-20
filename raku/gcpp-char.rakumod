our class Cchar::Basic does ICchar {
    has Str $.value is required;

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Cchar::Escape does ICchar {
    has IEscapesequence $.escapesequence is required;

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Cchar::Universal does ICchar {
    has Universalcharactername $.universalcharactername is required;

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Schar::Basic does ISchar {
    has Str $.value is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Schar::Escape does ISchar {
    has IEscapesequence $.escapesequence is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Schar::Ucn does ISchar {
    has Universalcharactername $.universalcharactername is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class CharacterLiteralPrefix::U    does ICharacterLiteralPrefix { 

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class CharacterLiteralPrefix::BigU does ICharacterLiteralPrefix { 

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class CharacterLiteralPrefix::L    does ICharacterLiteralPrefix { 

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

#-------------------------------
# token literal:sym<char> { <character-literal> }
our class CharacterLiteral {
    has ICharacterLiteralPrefix $.character-literal-prefix;
    has ICchar                  @.cchar;

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Universalcharactername {
    has Hexquad $.first is required;
    has Hexquad $.second;

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

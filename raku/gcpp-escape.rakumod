our class Escapesequence::Simple does IEscapesequence {
    has ISimpleescapesequence $.simpleescapesequence is required;

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Escapesequence::Octal does IEscapesequence {
    has Octalescapesequence $.octalescapesequence is required;

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Escapesequence::Hex does IEscapesequence {
    has Hexadecimalescapesequence $.hexadecimalescapesequence is required;

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Simpleescapesequence::Slash does ISimpleescapesequence { 
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Simpleescapesequence::Quote does ISimpleescapesequence { 
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Simpleescapesequence::Question does ISimpleescapesequence { 
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Simpleescapesequence::DoubleSlash does ISimpleescapesequence { 
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Simpleescapesequence::A does ISimpleescapesequence { 
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Simpleescapesequence::B does ISimpleescapesequence { 
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Simpleescapesequence::F does ISimpleescapesequence { 
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Simpleescapesequence::N does ISimpleescapesequence { 
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Simpleescapesequence::R does ISimpleescapesequence { 
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Simpleescapesequence::T does ISimpleescapesequence { 
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Simpleescapesequence::V does ISimpleescapesequence { 
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Simpleescapesequence::RnN does ISimpleescapesequence { 
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Octalescapesequence {
    has Octaldigit @.digits is required;

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Hexadecimalescapesequence {
    has Hexadecimaldigit @.digits is required;

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

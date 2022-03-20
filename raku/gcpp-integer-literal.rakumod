our class IntegerLiteral::Dec 
does IIntegerLiteral {

    has DecimalLiteral $.decimal-literal is required;
    has IIntegersuffix $.integersuffix;

    has $.text;

    method gist {

        say "need write gist!";
        ddt self;
        exit;
    }
}

our class IntegerLiteral::Oct 
does IIntegerLiteral {

    has OctalLiteral       $.octal-literal is required;
    has IIntegersuffix      $.integersuffix;

    has $.text;

    method gist {

        say "need write gist!";
        ddt self;
        exit;
    }
}

our class IntegerLiteral::Hex 
does IIntegerLiteral {

    has HexadecimalLiteral $.hexadecimal-literal is required;
    has IIntegersuffix      $.integersuffix;

    has $.text;

    method gist {

        say "need write gist!";
        ddt self;
        exit;
    }
}

our class IntegerLiteral::Bin 
does IIntegerLiteral {

    has BinaryLiteral      $.binary-literal is required;
    has IIntegersuffix      $.integersuffix;

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Digit { 
    has Str $.value is required; 

    has $.text;

    method gist {

        say "need write gist!";
        ddt self;
        exit;
    }
}

our class DecimalLiteral { 
    has Str $.value is required; 

    has $.text;

    method gist {

        say "need write gist!";
        ddt self;
        exit;
    }
}

our class OctalLiteral { 
    has Str $.value is required; 

    has $.text;

    method gist {

        say "need write gist!";
        ddt self;
        exit;
    }
}

our class HexadecimalLiteral {
    has Str $.value is required; 

    has $.text;

    method gist {

        say "need write gist!";
        ddt self;
        exit;
    }
}

our class BinaryLiteral { 
    has Str $.value is required; 

    has $.text;

    method gist {

        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Nonzerodigit { 
    has Str $.value is required; 

    has $.text;

    method gist {

        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Octaldigit { 
    has Str $.value is required; 

    has $.text;

    method gist {

        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Hexadecimaldigit { 
    has Str $.value is required; 

    has $.text;

    method gist {

        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Binarydigit { 
    has Str $.value is required; 

    has $.text;

    method gist {

        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Hexquad { 
    has Quad @hexadecimaldigit is required;

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

our subset Quad of List where (HexadecimalLiteral, HexadecimalLiteral, HexadecimalLiteral, HexadecimalLiteral);


# token literal:sym<str> { <string-literal> }
our class StringLiteral does ILiteral { 
    has Str $.value;

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Rawstring { 
    has Str $.value is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}


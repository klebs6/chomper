use Data::Dump::Tree;

use gcpp-roles;

our class Digit { 
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

our class Nondigit {
    has Str $.value is required; 

    has $.text;

    method gist {

        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Digitsequence { 
    has Digit @.digits is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

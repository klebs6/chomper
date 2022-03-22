use Data::Dump::Tree;

use gcpp-roles;

our class Digit { 
    has Str $.value is required; 

    has $.text;

    method gist {
        $.value
    }
}

our class Nonzerodigit { 
    has Str $.value is required; 

    has $.text;

    method gist {
        $.value
    }
}

our class Nondigit {
    has Str $.value is required; 

    has $.text;

    method gist {
        $.value
    }
}

our class Digitsequence { 
    has Digit @.digits is required;

    has $.text;

    method gist{
        @.digits>>.gist.join("")
    }
}

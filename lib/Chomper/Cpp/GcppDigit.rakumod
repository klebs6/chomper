unit module Chomper::Cpp::GcppDigit;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;

our class Digit { 
    has Str $.value is required; 

    has $.text;

    method gist(:$treemark=False) {
        $.value
    }
}

our class Nonzerodigit { 
    has Str $.value is required; 

    has $.text;

    method gist(:$treemark=False) {
        $.value
    }
}

our class Nondigit {
    has Str $.value is required; 

    has $.text;

    method gist(:$treemark=False) {
        $.value
    }
}

our class Digitsequence { 
    has Digit @.digits is required;

    has $.text;

    method gist(:$treemark=False) {
        @.digits>>.gist(:$treemark).join("")
    }
}
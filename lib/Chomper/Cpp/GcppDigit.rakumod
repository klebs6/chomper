unit module Chomper::Cpp::GcppDigit;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;

class Digit is export { 
    has Str $.value is required; 

    has $.text;

    method name {
        'Digit'
    }

    method gist(:$treemark=False) {
        $.value
    }
}

class NonzeroDigit is export { 
    has Str $.value is required; 

    has $.text;

    method name {
        'NonzeroDigit'
    }

    method gist(:$treemark=False) {
        $.value
    }
}

class Nondigit is export {
    has Str $.value is required; 

    has $.text;

    method name {
        'Nondigit'
    }

    method gist(:$treemark=False) {
        $.value
    }
}

class DigitSequence is export { 
    has Digit @.digits is required;

    has $.text;

    method name {
        'DigitSequence'
    }

    method gist(:$treemark=False) {
        @.digits>>.gist(:$treemark).join("")
    }
}

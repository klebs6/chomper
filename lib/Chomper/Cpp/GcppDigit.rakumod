unit module Chomper::Cpp::GcppDigit;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;

class Digit is export { 
    has Str $.value is required; 

    has $.text;

    method gist(:$treemark=False) {
        $.value
    }
}

class Nonzerodigit is export { 
    has Str $.value is required; 

    has $.text;

    method gist(:$treemark=False) {
        $.value
    }
}

class Nondigit is export {
    has Str $.value is required; 

    has $.text;

    method gist(:$treemark=False) {
        $.value
    }
}

class Digitsequence is export { 
    has Digit @.digits is required;

    has $.text;

    method gist(:$treemark=False) {
        @.digits>>.gist(:$treemark).join("")
    }
}

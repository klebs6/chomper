unit module Chomper::Cpp::GcppTypedef;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;
use Chomper::Cpp::GcppIdent;

our class TypedefName { 
    has Identifier $.identifier is required;

    has $.text;

    method gist(:$treemark=False) {
        $.identifier.gist(:$treemark)
    }
}

our role Typedef::Actions {

    method typedef-name($/) {
        make $<identifier>.made
    }
}

our role Typedef::Rules {
    rule typedef-name { 
        <identifier> 
    }
}
use Data::Dump::Tree;

use gcpp-roles;
use gcpp-ident;

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

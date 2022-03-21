use Data::Dump::Tree;

use gcpp-roles;
use gcpp-ident;

# rule typedef-name { 
#   <identifier> 
# }
our class TypedefName { 
    has Identifier $.identifier is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our role Typedef::Actions {

    # rule typedef-name { <identifier> } 
    method typedef-name($/) {
        make $<identifier>.made
    }
}

our role Typedef::Rules {
    rule typedef-name { 
        <identifier> 
    }
}

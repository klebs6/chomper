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

    rule typedef-name { 
        <identifier> 
    }
}

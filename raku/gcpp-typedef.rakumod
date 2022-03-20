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


# rule access-specifier:sym<private> { 
#   <private> 
# }
our class AccessSpecifier::Private does IAccessSpecifier { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule access-specifier:sym<protected> { 
#   <protected> 
# }
our class AccessSpecifier::Protected does IAccessSpecifier {

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule access-specifier:sym<public> { 
#   <public> 
# }
our class AccessSpecifier::Public does IAccessSpecifier { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

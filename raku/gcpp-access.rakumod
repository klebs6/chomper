
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

our role Access::Actions {

    # rule access-specifier:sym<private> { <private> }
    method access-specifier:sym<private>($/) {
        make AccessSpecifier::Private.new
    }

    # rule access-specifier:sym<protected> { <protected> }
    method access-specifier:sym<protected>($/) {
        make AccessSpecifier::Protected.new
    }

    # rule access-specifier:sym<public> { <public> }
    method access-specifier:sym<public>($/) {
        make AccessSpecifier::Public.new
    }
}

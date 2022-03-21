use Data::Dump::Tree;

use gcpp-roles;

# rule access-specifier:sym<private> { 
#   <private> 
# }
our class AccessSpecifier::Private does IAccessSpecifier { 

    has $.text;

    method gist{
        "private"
    }
}

# rule access-specifier:sym<protected> { 
#   <protected> 
# }
our class AccessSpecifier::Protected does IAccessSpecifier {

    has $.text;

    method gist{
        "protected"
    }
}

# rule access-specifier:sym<public> { 
#   <public> 
# }
our class AccessSpecifier::Public does IAccessSpecifier { 

    has $.text;

    method gist{
        "public"
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

our role Access::Rules {

    proto rule access-specifier { * }
    rule access-specifier:sym<private>   { <private> }
    rule access-specifier:sym<protected> { <protected> }
    rule access-specifier:sym<public>    { <public> }
}

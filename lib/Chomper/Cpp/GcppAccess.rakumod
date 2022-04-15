unit module Chomper::Cpp::GcppAccess;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;

# rule access-specifier:sym<private> { 
#   <private> 
# }
class AccessSpecifier::Private does IAccessSpecifier is export { 

    has $.text;

    method gist(:$treemark=False) {
        "private"
    }
}

# rule access-specifier:sym<protected> { 
#   <protected> 
# }
class AccessSpecifier::Protected does IAccessSpecifier is export {

    has $.text;

    method gist(:$treemark=False) {
        "protected"
    }
}

# rule access-specifier:sym<public> { 
#   <public> 
# }
class AccessSpecifier::Public does IAccessSpecifier is export { 

    has $.text;

    method gist(:$treemark=False) {
        "public"
    }
}

package AccessGrammar is export {

    our role Actions {

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

    our role Rules {

        proto rule access-specifier { * }
        rule access-specifier:sym<private>   { <private> }
        rule access-specifier:sym<protected> { <protected> }
        rule access-specifier:sym<public>    { <public> }
    }
}

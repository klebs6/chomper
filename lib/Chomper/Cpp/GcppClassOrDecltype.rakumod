unit module Chomper::Cpp::GcppClassOrDecltype;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;
use Chomper::Cpp::GcppDecltype;

# rule class-or-decl-type:sym<class> { 
#   <nested-name-specifier>? 
#   <class-name> 
# }
class ClassOrDeclType::Class does IClassOrDeclType is export {
    has INestedNameSpecifier $.nested-name-specifier;
    has IClassName           $.class-name is required;
    has $.text;

    method gist(:$treemark=False) {

        my $builder = "";

        if $.nested-name-specifier {
            $builder ~= $.nested-name-specifier.gist(:$treemark);
        }

        $builder ~ $.class-name.gist(:$treemark)
    }
}

# rule class-or-decl-type:sym<decltype> { 
#   <decltype-specifier> 
# }
class ClassOrDeclType::Decltype does IClassOrDeclType is export {
    has DecltypeSpecifier $.decltype-specifier is required;
    has $.text;

    method gist(:$treemark=False) {
        $.decltype-specifier.gist(:$treemark)
    }
}

package ClassOrDeclTypeGrammar is export {

    our role Actions {

        # rule class-or-decl-type:sym<class> { <nested-name-specifier>? <class-name> }
        method class-or-decl-type:sym<class>($/) {

            my $prefix = $<nested-name-specifier>.made;
            my $base   = $<class-name>.made;

            if $prefix {
                make ClassOrDeclType::Class.new(
                    nested-name-specifier => $prefix,
                    class-name            => $base,
                )

            } else {

                make $base
            }
        }

        # rule class-or-decl-type:sym<decltype> { <decltype-specifier> } 
        method class-or-decl-type:sym<decltype>($/) {
            make $<decltype-specifier>.made
        }
    }

    our role Rules {

        proto rule class-or-decl-type { * }
        rule class-or-decl-type:sym<class>    { <nested-name-specifier>?  <class-name> }
        rule class-or-decl-type:sym<decltype> { <decltype-specifier> }
    }
}

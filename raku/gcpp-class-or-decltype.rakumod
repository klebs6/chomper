use Data::Dump::Tree;

use gcpp-roles;
use gcpp-decltype;

# rule class-or-decl-type:sym<class> { 
#   <nested-name-specifier>? 
#   <class-name> 
# }
our class ClassOrDeclType::Class does IClassOrDeclType {
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
our class ClassOrDeclType::Decltype does IClassOrDeclType {
    has DecltypeSpecifier $.decltype-specifier is required;
    has $.text;

    method gist(:$treemark=False) {
        $.decltype-specifier.gist(:$treemark)
    }
}

our role ClassOrDeclType::Actions {

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

our role ClassOrDeclType::Rules {

    proto rule class-or-decl-type { * }
    rule class-or-decl-type:sym<class>    { <nested-name-specifier>?  <class-name> }
    rule class-or-decl-type:sym<decltype> { <decltype-specifier> }
}

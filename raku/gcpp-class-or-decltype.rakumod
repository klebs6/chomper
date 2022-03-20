
# rule class-or-decl-type:sym<class> { 
#   <nested-name-specifier>? 
#   <class-name> 
# }
our class ClassOrDeclType::Class does IClassOrDeclType {
    has INestedNameSpecifier $.nested-name-specifier;
    has IClassName           $.class-name is required;
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule class-or-decl-type:sym<decltype> { 
#   <decltype-specifier> 
# }
our class ClassOrDeclType::Decltype does IClassOrDeclType {
    has DecltypeSpecifier $.decltype-specifier is required;
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}


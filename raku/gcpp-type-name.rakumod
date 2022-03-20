# rule the-type-name:sym<simple-template-id> { <simple-template-id> }
our class TheTypeName::SimpleTemplateId does ITheTypeName {
    has SimpleTemplateId $.simple-template-id is required;
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule the-type-name:sym<class> { <class-name> }
our class TheTypeName::Class does ITheTypeName {
    has IClassName $.class-name is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule the-type-name:sym<enum> { <enum-name> }
our class TheTypeName::Enum does ITheTypeName {
    has EnumName $.enum-name is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule the-type-name:sym<typedef> { 
#   <typedef-name> 
# }
our class TheTypeName::Typedef does ITheTypeName {
    has TypedefName $.typedef-name is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule full-type-name { 
#   <nested-name-specifier>? 
#   <the-type-name> 
# }
our class FullTypeName does IPostListHead does IDeclSpecifier { 
    has INestedNameSpecifier $.nested-name-specifier;
    has ITheTypeName         $.the-type-name is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

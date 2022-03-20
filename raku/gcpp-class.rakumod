
# rule class-name:sym<id> { <identifier> }
our class ClassName::Id does IClassName {
    has Identifier $.identifier is required;
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule class-name:sym<template-id> { <simple-template-id> }
our class ClassName::TemplateId does IClassName {
    has SimpleTemplateId $.simple-template-id is required;
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule class-specifier { 
#   <class-head> 
#   <.left-brace> 
#   <member-specification>? 
#   <.right-brace> 
# } #-----------------------------
our class ClassSpecifier { 
    has MemberSpecification $.member-specification;
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}


# rule class-head:sym<class> { 
# <.class-key> 
# <attribute-specifier-seq>? 
# [ <class-head-name> <class-virt-specifier>? ]? 
# <base-clause>? }
our class ClassHead::Class does IClassHead {
    has IAttributeSpecifierSeq $.attribute-specifier-seq;
    has ClassHeadName         $.class-head-name;
    has ClassVirtSpecifier    $.class-virt-specifier;
    has BaseClause            $.base-clause;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule class-head:sym<union> { 
#   <union> 
#   <attribute-specifier-seq>? 
#   [ <class-head-name> <class-virt-specifier>? ]? 
# }
our class ClassHead::Union does IClassHead {
    has IAttributeSpecifierSeq $.attribute-specifier-seq;
    has ClassHeadName         $.class-head-name;
    has ClassVirtSpecifier    $.class-virt-specifier;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule class-head-name { 
#   <nested-name-specifier>? 
#   <class-name> 
# }
our class ClassHeadName { 
    has INestedNameSpecifier $.nested-name-specifier;
    has IClassName           $.class-name is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule class-virt-specifier { 
#   <final> 
# }
our class ClassVirtSpecifier {

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule class-key:sym<class> { 
#   <.class_> 
# }
our class ClassKey::Class does IClassKey {

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule class-key:sym<struct> { 
#   <.struct> 
# }
our class ClassKey::Struct does IClassKey { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

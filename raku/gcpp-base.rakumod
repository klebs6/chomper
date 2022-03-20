
# rule base-clause { 
#   <colon> 
#   <base-specifier-list> 
# }
our class BaseClause { 
    has BaseSpecifierList $.base-specifier-list is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule base-specifier-list { 
#   <base-specifier> 
#   <ellipsis>? 
#   [ <.comma> <base-specifier> <ellipsis>? ]* 
# } #-----------------------------
our class BaseSpecifierList { 
    has IBaseSpecifier @.base-specifiers is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule base-specifier:sym<base-type> { 
#   <attribute-specifier-seq>? 
#   <base-type-specifier> 
# }
our class BaseSpecifier::BaseType does IBaseSpecifier {
    has IAttributeSpecifierSeq $.attribute-specifier-seq;
    has BaseTypeSpecifier $.base-type-specifier is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule base-specifier:sym<virtual> { 
#   <attribute-specifier-seq>? 
#   <virtual> 
#   <access-specifier>? 
#   <base-type-specifier> 
# }
our class BaseSpecifier::Virtual does IBaseSpecifier {
    has IAttributeSpecifierSeq $.attribute-specifier-seq;
    has IAccessSpecifier $.access-specifier;
    has BaseTypeSpecifier $.base-type-specifier is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule base-specifier:sym<access> { 
#   <attribute-specifier-seq>? 
#   <access-specifier> 
#   <virtual>? 
#   <base-type-specifier> 
# }
our class BaseSpecifier::Access does IBaseSpecifier {
    has IAttributeSpecifierSeq $.attribute-specifier-seq;
    has IAccessSpecifier       $.access-specifier    is required;
    has Bool                  $.is-virtual          is required;
    has BaseTypeSpecifier     $.base-type-specifier is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule base-type-specifier { 
#   <class-or-decl-type> 
# }
our class BaseTypeSpecifier { 
    has IClassOrDeclType $.class-or-decl-type is required;
}

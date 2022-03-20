

# rule enum-name { <identifier> }
our class EnumName { 
    has Identifier $.identifier is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule enum-specifier { 
#   <enum-head> 
#   <.left-brace> 
#   [ <enumerator-list> <.comma>? ]? 
#   <.right-brace> 
# }
our class EnumSpecifier { 
    has EnumeratorList $.enumerator-list;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule enum-head { 
#   <.enumkey> 
#   <attribute-specifier-seq>? 
#   [ <nested-name-specifier>? <identifier> ]? 
#   <enumbase>? 
# }
our class EnumHead { 
    has IAttributeSpecifierSeq $.attribute-specifier-seq;
    has INestedNameSpecifier   $.nested-name-specifier;
    has Identifier            $.identifier;
    has IEnumBase              $.enum-base;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule opaque-enum-declaration { 
#   <.enumkey> 
#   <attribute-specifier-seq>? 
#   <identifier> 
#   <enumbase>? 
#   <semi> 
# }
our class OpaqueEnumDeclaration { 
    has IComment               $.comment;
    has IAttributeSpecifierSeq $.attribute-specifier-seq;
    has Identifier             $.identifier is required;
    has IEnumBase              $.enum-base is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule enumkey { 
#   <enum_> 
#   [ <class_> || <struct> ]? 
# }
our class Enumkey { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule enumbase { 
#   <colon> 
#   <type-specifier-seq> 
# }
our class Enumbase { 

    has ITypeSpecifierSeq $.type-specifier-seq is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule enumerator-list { 
#   <enumerator-definition> 
#   [ <.comma> <enumerator-definition> ]* 
# }
our class EnumeratorList { 

    has EnumeratorDefinition @.enumerator-definitions is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule enumerator-definition { 
#   <enumerator> 
#   [ <assign> <constant-expression> ]? 
# }
our class EnumeratorDefinition { 
    has Enumerator          $.enumerator is required;
    has IConstantExpression $.constant-expression;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule enumerator { 
#   <identifier> 
# }
our class Enumerator { 
    has Identifier $.identifier is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

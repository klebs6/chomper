
# rule attribute-specifier-seq { <attribute-specifier>+ }
our class AttributeSpecifierSeq { 
    has IAttributeSpecifier @.attribute-specifier is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}


# rule attribute-specifier:sym<double-braced> { 
#   <.left-bracket> 
#   <.left-bracket> 
#   <attribute-list>? 
#   <.right-bracket> 
#   <.right-bracket> 
# }
our class AttributeSpecifier::DoubleBraced does IAttributeSpecifier {
    has AttributeList $.attribute-list;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule attribute-specifier:sym<alignment> { 
#   <alignmentspecifier> 
# }
our class AttributeSpecifier::Alignment does IAttributeSpecifier {
    has IAlignmentSpecifier $.alignmentspecifier is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule attribute-list { 
#   <attribute> 
#   [ <.comma> <attribute> ]* 
#   <ellipsis>? 
# }
our class AttributeList { 
    has Attribute @.attributes is required;
    has Bool      $.has-ellipsis is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule attribute { 
#   [ <attribute-namespace> <doublecolon> ]? 
#   <identifier> 
#   <attribute-argument-clause>? 
# }
our class Attribute { 
    has AttributeNamespace      $.attribute-namespace;
    has Identifier              $.identifier is required;
    has AttributeArgumentClause $.attribute-argument-clause;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule attribute-namespace { <identifier> }
our class AttributeNamespace { 
    has Identifier $.identifier is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule attribute-argument-clause { 
#   <.left-paren> 
#   <balanced-token-seq>? 
#   <.right-paren> 
# }
our class AttributeArgumentClause { 
    has BalancedTokenSeq $.balanced-token-seq;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule attribute-declaration { 
#   <attribute-specifier-seq> 
#   <.semi> 
# }
our class AttributeDeclaration { 
    has IComment               $.comment;
    has IAttributeSpecifierSeq $.attribute-specifier-seq is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}


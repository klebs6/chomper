

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

our role Enum::Actions {

    # rule enum-name { <identifier> }
    method enum-name($/) {
        make $<identifier>.made
    }

    # rule enum-specifier { <enum-head> <.left-brace> [ <enumerator-list> <.comma>? ]? <.right-brace> }
    method enum-specifier($/) {
        make EnumSpecifier.new(
            enumerator-list => $<enumerator-list>.made,
        )
    }

    # rule enum-head { <.enumkey> <attribute-specifier-seq>? [ <nested-name-specifier>? <identifier> ]? <enumbase>? }
    method enum-head($/) {
        make EnumHead.new(
            attribute-specifier-seq => $<attribute-specifier-seq>.made,
            nested-name-specifier   => $<nested-name-specifier>.made,
            identifier              => $<identifier>.made,
            enum-base               => $<enum-base>.made,
        )
    }

    # rule opaque-enum-declaration { <.enumkey> <attribute-specifier-seq>? <identifier> <enumbase>? <semi> }
    method opaque-enum-declaration($/) {
        make OpaqueEnumDeclaration.new(
            comment                 => $<semi>.made,
            attribute-specifier-seq => $<attribute-specifier-seq>.made,
            identifier              => $<identifier>.made,
            enum-base               => $<enum-base>.made,
        )
    }

    # rule enumkey { <enum_> [ <class_> || <struct> ]? }
    method enumkey($/) {
        make Enumkey.new
    }

    # rule enumbase { <colon> <type-specifier-seq> }
    method enumbase($/) {
        make Enumbase.new(
            type-specifier-seq => $<type-specifier-seq>.made,
        )
    }

    # rule enumerator-list { <enumerator-definition> [ <.comma> <enumerator-definition> ]* }
    method enumerator-list($/) {
        make $<enumerator-definition>>>.made
    }

    # rule enumerator-definition { <enumerator> [ <assign> <constant-expression> ]? }
    method enumerator-definition($/) {
        make EnumeratorDefinition.new(
            enumerator          => $<enumerator>.made,
            constant-expression => $<constant-expression>.made,
        )
    }

    # rule enumerator { <identifier> }
    method enumerator($/) {
        make $<identifier>.made
    }
}

our role Enum::Rules {

    rule elaborated-type-specifier:sym<enum> {
        <enum_> <nested-name-specifier>? <identifier>
    }

    rule enum-name {
        <identifier>
    }

    rule enum-specifier {
        <enum-head>
        <left-brace>
        [ <enumerator-list> <comma>?  ]?
        <right-brace>
    }

    rule enum-head {
        <enumkey>
        <attribute-specifier-seq>?
        [ <nested-name-specifier>? <identifier> ]?
        <enumbase>?
    }

    rule opaque-enum-declaration {
        <enumkey>
        <attribute-specifier-seq>?
        <identifier>
        <enumbase>?
        <semi>
    }

    rule enumkey {
        <enum_>
        [  <class_> || <struct> ]?
    }

    rule enumbase {
        <colon> <type-specifier-seq>
    }

    rule enumerator-list {
        <enumerator-definition>
        [ <comma> <enumerator-definition> ]*
    }

    rule enumerator-definition {
        <enumerator>
        [ <assign> <constant-expression> ]?
    }

    rule enumerator {
        <identifier>
    }
}

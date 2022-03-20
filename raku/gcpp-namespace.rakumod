# rule namespace-name:sym<original> { <original-namespace-name> }
our class NamespaceName::Original does INamespaceName {
    has OriginalNamespaceName $.original-namespace-name is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule namespace-name:sym<alias> { <namespace-alias> }
our class NamespaceName::Alias does INamespaceName {
    has NamespaceAlias $.namespace-alias is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule original-namespace-name { <identifier> }
our class OriginalNamespaceName { 
    has Identifier $.identifier is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule namespace-tag:sym<ident> { <identifier> }
our class NamespaceTag::Ident does INamespaceTag {
    has Identifier $.identifier is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule namespace-tag:sym<ns-name> { <original-namespace-name> } 
our class NamespaceTag::NsName does INamespaceTag {
    has OriginalNamespaceName $.original-namespace-name is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule namespace-definition { 
#   <inline>? 
#   <namespace> 
#   <namespace-tag>? 
#   <.left-brace> 
#   <namespaceBody=declarationseq>? 
#   <.right-brace> 
# }
our class NamespaceDefinition { 
    has Bool           $.inline is required;
    has INamespaceTag   $.namespace-tag;
    has IDeclarationseq $.namespace-body;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule namespace-alias { <identifier> }
our class NamespaceAlias { 
    has Identifier $.identifier is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule namespace-alias-definition { 
#   <namespace> 
#   <identifier> 
#   <assign> 
#   <qualifiednamespacespecifier> 
#   <semi> 
# }
our class NamespaceAliasDefinition { 
    has IComment                    $.comment;
    has Identifier                  $.identifier is required;
    has Qualifiednamespacespecifier $.qualifiednamespacespecifier is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule qualifiednamespacespecifier { 
#   <nested-name-specifier>? 
#   <namespace-name> 
# } 
our class Qualifiednamespacespecifier { 
    has INestedNameSpecifier $.nested-name-specifier;
    has INamespaceName       $.namespace-name is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

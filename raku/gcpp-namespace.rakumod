use Data::Dump::Tree;

use gcpp-roles;
use gcpp-ident;
use gcpp-declaration;

# rule namespace-alias { <identifier> }
our class NamespaceAlias { 
    has Identifier $.identifier is required;

    has $.text;

    method gist{
        $.identifier.gist
    }
}

# rule original-namespace-name { <identifier> }
our class OriginalNamespaceName { 
    has Identifier $.identifier is required;

    has $.text;

    method gist{
        $.identifier.gist
    }
}

# rule namespace-name:sym<original> { <original-namespace-name> }
our class NamespaceName::Original does INamespaceName {
    has OriginalNamespaceName $.original-namespace-name is required;

    has $.text;

    method gist{
        $.original-namespace-name.gist
    }
}

# rule namespace-name:sym<alias> { <namespace-alias> }
our class NamespaceName::Alias does INamespaceName {
    has NamespaceAlias $.namespace-alias is required;

    has $.text;

    method gist{
        $.namespace-alias.gist
    }
}

# rule namespace-tag:sym<ident> { <identifier> }
our class NamespaceTag::Ident does INamespaceTag {
    has Identifier $.identifier is required;

    has $.text;

    method gist{
        $.identifier.gist
    }
}

# rule namespace-tag:sym<ns-name> { <original-namespace-name> } 
our class NamespaceTag::NsName does INamespaceTag {
    has OriginalNamespaceName $.original-namespace-name is required;

    has $.text;

    method gist{
        $.original-namespace-name.gist
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

        my $builder = "";

        if $.inline {
            $builder ~= "inline ";
        }

        $builder ~= "namespace ";

        if $.namespace-tag {
            $builder ~= $.namespace-tag.gist;
        }

        $builder ~= "\{";

        if $.namespace-body {
            $builder ~= $.namespace-body.gist;
        }

        $builder ~ "}"
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

    method gist {
        my $builder = "";

        my $n = $.nested-name-specifier;

        if $n {
            $builder ~= $n.gist ~ " ";
        }

        $builder ~ $.namespace-name.gist
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

    method gist {

        my $builder = "";

        if $.comment {
            $builder ~= $.comment.gist ~ "\n";
        }

        $builder 
        ~ "namespace " 
        ~ $.identifier.gist 
        ~ " = " 
        ~ $.qualifiednamespacespecifier.gist 
        ~ ";"
    }
}

our role Namespace::Actions {

    # rule namespace-name:sym<original> { <original-namespace-name> }
    method namespace-name:sym<original>($/) {
        make $<original-namespace-name>.made
    }

    # rule namespace-name:sym<alias> { <namespace-alias> }
    method namespace-name:sym<alias>($/) {
        make $<namespace-alias>.made
    }

    # rule original-namespace-name { <identifier> } 
    method original-namespace-name($/) {
        make $<identifier>.made
    }

    # rule namespace-tag:sym<ident> { <identifier> }
    method namespace-tag:sym<ident>($/) {
        make $<identifier>.made
    }

    # rule namespace-tag:sym<ns-name> { 
    #   <original-namespace-name> 
    # }
    method namespace-tag:sym<ns-name>($/) {
        make $<original-namespace-name>.made
    }

    # rule namespace-definition { 
    #   <inline>? 
    #   <namespace> 
    #   <namespace-tag>? 
    #   <.left-brace> 
    #   <namespaceBody=declarationseq>? 
    #   <.right-brace> 
    # }
    method namespace-definition($/) {
        make NamespaceDefinition.new(
            inline         => $<inline>.made,
            namespace-tag  => $<namespace-tag>.made,
            namespace-body => $<namespace-body>.made,
            text           => ~$/,
        )
    }

    # rule namespace-alias { <identifier> }
    method namespace-alias($/) {
        make $<identifier>.made
    }

    # rule namespace-alias-definition { <namespace> <identifier> <assign> <qualifiednamespacespecifier> <semi> }
    method namespace-alias-definition($/) {
        make NamespaceAliasDefinition.new(
            comment                     => $<semi>.made,
            identifier                  => $<identifier>.made,
            qualifiednamespacespecifier => $<qualifiednamespacespecifier>.made,
            text                        => ~$/,
        )
    }

    # rule qualifiednamespacespecifier { <nested-name-specifier>? <namespace-name> } 
    method qualifiednamespacespecifier($/) {

        my $prefix = $<nested-name-specifier>.made;
        my $body   = $<namespace-name>.made;

        if $prefix {
            make Qualifiednamespacespecifier.new(
                nested-name-specifier => $prefix,
                namespace-name        => $body,
                text                  => ~$/,
            )
        } else {
            make $body
        }
    }
}

our role Namespace::Rules {

    proto rule namespace-name { * }
    rule namespace-name:sym<original> { <original-namespace-name> }
    rule namespace-name:sym<alias>    { <namespace-alias> }

    rule original-namespace-name {
        <identifier>
    }

    #--------------------
    proto rule namespace-tag { * }
    rule namespace-tag:sym<ident>   { <identifier> }
    rule namespace-tag:sym<ns-name> { <original-namespace-name> }

    #--------------------
    rule namespace-definition {
        <inline>?
        <namespace>
        <namespace-tag>?
        <left-brace>
        <namespaceBody=declarationseq>?
        <right-brace>
    }

    rule namespace-alias {
        <identifier>
    }

    rule namespace-alias-definition {
        <namespace>
        <identifier>
        <assign>
        <qualifiednamespacespecifier>
        <semi>
    }

    rule qualifiednamespacespecifier {
        <nested-name-specifier>?
        <namespace-name>
    }
}

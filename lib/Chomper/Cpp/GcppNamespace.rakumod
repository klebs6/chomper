unit module Chomper::Cpp::GcppNamespace;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;
use Chomper::Cpp::GcppIdent;
use Chomper::Cpp::GcppDeclaration;

# rule namespace-alias { <identifier> }
class NamespaceAlias is export { 
    has Identifier $.identifier is required;

    has $.text;

    method name {
        'NamespaceAlias'
    }

    method gist(:$treemark=False) {
        $.identifier.gist(:$treemark)
    }
}

# rule original-namespace-name { <identifier> }
class OriginalNamespaceName is export { 
    has Identifier $.identifier is required;

    has $.text;

    method name {
        'OriginalNamespaceName'
    }

    method gist(:$treemark=False) {
        $.identifier.gist(:$treemark)
    }
}

package NamespaceName is export {

    # rule namespace-name:sym<original> { <original-namespace-name> }
    our class Original does INamespaceName {
        has OriginalNamespaceName $.original-namespace-name is required;

        has $.text;

        method name {
            'NamespaceName::Original'
        }

        method gist(:$treemark=False) {
            $.original-namespace-name.gist(:$treemark)
        }
    }

    # rule namespace-name:sym<alias> { <namespace-alias> }
    our class Alias does INamespaceName {
        has NamespaceAlias $.namespace-alias is required;

        has $.text;

        method name {
            'NamespaceName::Alias'
        }

        method gist(:$treemark=False) {
            $.namespace-alias.gist(:$treemark)
        }
    }
}

package NamespaceTag is export {

    # rule namespace-tag:sym<ident> { <identifier> }
    our class Ident does INamespaceTag {
        has Identifier $.identifier is required;

        has $.text;

        method name {
            'NamespaceTag::Ident'
        }

        method gist(:$treemark=False) {
            $.identifier.gist(:$treemark)
        }
    }

    # rule namespace-tag:sym<ns-name> { <original-namespace-name> } 
    our class NsName does INamespaceTag {
        has OriginalNamespaceName $.original-namespace-name is required;

        has $.text;

        method name {
            'NamespaceTag::NsName'
        }

        method gist(:$treemark=False) {
            $.original-namespace-name.gist(:$treemark)
        }
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
class NamespaceDefinition is export { 
    has Bool           $.inline is required;
    has INamespaceTag   $.namespace-tag;
    has IDeclarationSeq $.namespace-body;

    has $.text;

    method name {
        'NamespaceDefinition'
    }

    method gist(:$treemark=False) {

        my $builder = "";

        if $.inline {
            $builder ~= "inline ";
        }

        $builder ~= "namespace ";

        if $.namespace-tag {
            $builder ~= $.namespace-tag.gist(:$treemark);
        }

        $builder ~= "\{";

        if $.namespace-body {
            $builder ~= $.namespace-body.gist(:$treemark);
        }

        $builder ~ "}"
    }
}

# rule qualifiednamespacespecifier { 
#   <nested-name-specifier>? 
#   <namespace-name> 
# } 
class QualifiedNamespaceSpecifier is export { 
    has INestedNameSpecifier $.nested-name-specifier;
    has INamespaceName       $.namespace-name is required;

    has $.text;

    method name {
        'QualifiedNamespaceSpecifier'
    }

    method gist(:$treemark=False) {
        my $builder = "";

        my $n = $.nested-name-specifier;

        if $n {
            $builder ~= $n.gist(:$treemark) ~ " ";
        }

        $builder ~ $.namespace-name.gist(:$treemark)
    }
}

# rule namespace-alias-definition { 
#   <namespace> 
#   <identifier> 
#   <assign> 
#   <qualifiednamespacespecifier> 
#   <semi> 
# }
class NamespaceAliasDefinition is export { 
    has IComment                    $.comment;
    has Identifier                  $.identifier is required;
    has QualifiedNamespaceSpecifier $.qualifiednamespacespecifier is required;

    has $.text;

    method name {
        'NamespaceAliasDefinition'
    }

    method gist(:$treemark=False) {

        my $builder = "";

        if $.comment {
            $builder ~= $.comment.gist(:$treemark) ~ "\n";
        }

        $builder 
        ~ "namespace " 
        ~ $.identifier.gist(:$treemark) 
        ~ " = " 
        ~ $.qualifiednamespacespecifier.gist(:$treemark) 
        ~ ";"
    }
}

package NamespaceGrammar is export {

    our role Actions {

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
                make QualifiedNamespaceSpecifier.new(
                    nested-name-specifier => $prefix,
                    namespace-name        => $body,
                    text                  => ~$/,
                )
            } else {
                make $body
            }
        }
    }

    our role Rules {

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
}

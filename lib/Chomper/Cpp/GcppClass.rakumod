unit module Chomper::Cpp::GcppClass;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;
use Chomper::Cpp::GcppIdent;
use Chomper::Cpp::GcppTemplate;
use Chomper::Cpp::GcppMember;
use Chomper::Cpp::GcppAttr;
use Chomper::Cpp::GcppBase;


# rule class-virt-specifier { 
#   <final> 
# }
class ClassVirtSpecifier is export {

    has $.text;

    method name {
        'ClassVirtSpecifier'
    }

    method gist(:$treemark=False) {
        "final"
    }
}

# rule class-head-name { 
#   <nested-name-specifier>? 
#   <class-name> 
# }
class ClassHeadName is export { 
    has INestedNameSpecifier $.nested-name-specifier;
    has IClassName           $.class-name is required;

    has $.text;

    method name {
        'ClassHeadName'
    }

    method gist(:$treemark=False) {

        my $builder = "";

        if $.nested-name-specifier {
            $builder ~= $.nested-name-specifier.gist(:$treemark);
        }

        $builder ~ $.class-name.gist(:$treemark)
    }
}

package ClassName is export {

    # rule class-name:sym<id> { <identifier> }
    our class Id does IClassName {
        has Identifier $.identifier is required;
        has $.text;

        method name {
            'ClassName::Id'
        }

        method gist(:$treemark=False) {
            $.identifier.gist(:$treemark)
        }
    }

    # rule class-name:sym<template-id> { <simple-template-id> }
    our class TemplateId does IClassName {
        has SimpleTemplateId $.simple-template-id is required;
        has $.text;

        method name {
            'ClassName::TemplateId'
        }

        method gist(:$treemark=False) {
            $.simple-template-id.gist(:$treemark)
        }
    }
}

# rule class-specifier { 
#   <class-head> 
#   <.left-brace> 
#   <member-specification>? 
#   <.right-brace> 
# } #-----------------------------
class ClassSpecifier is export { 
    has IClassHead $.class-head is required;
    has MemberSpecification $.member-specification;
    has $.text;

    method name {
        'ClassSpecifier'
    }

    method gist(:$treemark=False) {

        my $builder = $.class-head.gist(:$treemark) ~ " \{\n";

        if $.member-specification {
            $builder ~= $.member-specification.gist(:$treemark);
        }

        $builder ~ "}"
    }
}


package ClassHead is export {

    # rule class-head:sym<class> { 
    #   <.class-key> 
    #   <attribute-specifier-seq>? 
    #   [ <class-head-name> <class-virt-specifier>? ]? 
    #   <base-clause>? 
    # }
    our class Class_ does IClassHead {
        has IClassKey              $.class-key is required;
        has IAttributeSpecifierSeq $.attribute-specifier-seq;
        has ClassHeadName          $.class-head-name;
        has ClassVirtSpecifier     $.class-virt-specifier;
        has BaseClause             $.base-clause;

        has $.text;

        method name {
            'ClassHead::Class'
        }

        method gist(:$treemark=False) {

            my $builder = $.class-key.gist(:$treemark) ~ " ";

            if $.attribute-specifier-seq {
                $builder ~= $.attribute-specifier-seq.gist(:$treemark) ~ " ";
            }

            if $.class-head-name {
                $builder ~= $.class-head-name.gist(:$treemark) ~ " ";

                if $.class-virt-specifier {
                    $builder ~= $.class-virt-specifier.gist(:$treemark) ~ " ";
                }
            }

            if $.base-clause {
                $builder ~= $.base-clause.gist(:$treemark);
            }

            $builder
        }
    }

    # rule class-head:sym<union> { 
    #   <union> 
    #   <attribute-specifier-seq>? 
    #   [ <class-head-name> <class-virt-specifier>? ]? 
    # }
    our class Union_ does IClassHead {

        has IAttributeSpecifierSeq $.attribute-specifier-seq;
        has ClassHeadName         $.class-head-name;
        has ClassVirtSpecifier    $.class-virt-specifier;

        has $.text;

        method name {
            'ClassHead::Union'
        }

        method gist(:$treemark=False) {

            my $builder = "union ";

            if $.attribute-specifier-seq {
                $builder ~= $.attribute-specifier-seq.gist(:$treemark);
            }

            if $.class-head-name {

                $builder ~= $.class-head-name.gist(:$treemark) ~ " ";

                if $.class-virt-specifier {
                    $builder ~= $.class-virt-specifier.gist(:$treemark) ~ " ";
                }
            }

            $builder
        }
    }
}

package ClassKey is export {

    # rule class-key:sym<class> { 
    #   <.class_> 
    # }
    our class Class_ does IClassKey {

        has $.text;

        method name {
            'ClassKey::Class'
        }

        method gist(:$treemark=False) {
            "class"
        }
    }

    # rule class-key:sym<struct> { 
    #   <.struct> 
    # }
    our class Struct_ does IClassKey { 

        has $.text;

        method name {
            'ClassKey::Struct'
        }

        method gist(:$treemark=False) {
            "struct"
        }
    }
}

package ClassGrammar is export {

    our role Actions {

        # rule class-name:sym<id> { <identifier> }
        method class-name:sym<id>($/) {
            make $<identifier>.made
        }

        # rule class-name:sym<template-id> { <simple-template-id> }
        method class-name:sym<template-id>($/) {
            make $<simple-template-id>.made
        }

        # rule class-specifier { <class-head> <.left-brace> <member-specification>? <.right-brace> } 
        method class-specifier($/) {
            make ClassSpecifier.new(
                class-head           => $<class-head>.mde,
                member-specification => $<member-specification>.made,
            )
        }

        # rule class-head:sym<class> { 
        #   <.class-key> 
        #   <attribute-specifier-seq>? 
        #   [ <class-head-name> <class-virt-specifier>? ]? 
        #   <base-clause>? 
        # }
        method class-head:sym<class>($/) {
            make ClassHead::Class_.new(
                attribute-specifier-seq => $<attribute-specifier-seq>.made,
                class-head-name         => $<class-head-name>.made,
                class-virt-specifier    => $<class-virt-specifier>.made,
                base-clause             => $<base-clause>.made,
            )
        }

        # rule class-head:sym<union> { 
        #   <union> 
        #   <attribute-specifier-seq>? 
        #   [ <class-head-name> <class-virt-specifier>? ]? 
        # } 
        method class-head:sym<union>($/) {
            make ClassHead::Union_.new(
                attribute-specifier-seq => $<attribute-specifier-seq>.made,
                class-head-name         => $<class-head-name>.made,
                class-virt-specifier    => $<class-virt-specifier>.made,
            )
        }

        # rule class-head-name { <nested-name-specifier>? <class-name> }
        method class-head-name($/) {

            my $prefix = $<nested-name-specifier>.made;
            my $body   = $<class-name>.made;

            if $prefix {
                make ClassHeadName.new(
                    nested-name-specifier => $prefix,
                    class-name            => $body,
                )
            } else {
                make $body
            }
        }

        # rule class-virt-specifier { <final> } 
        method class-virt-specifier($/) {
            make ClassVirtSpecifier.new
        }

        # rule class-key:sym<class> { <.class_> }
        method class-key:sym<class>($/) {
            make ClassKey::Class_.new
        }

        # rule class-key:sym<struct> { <.struct> } 
        method class-key:sym<struct>($/) {
            make ClassKey::Struct_.new
        }
    }

    our role Rules {

        proto rule class-name { * }
        rule class-name:sym<id>          { <identifier> }
        rule class-name:sym<template-id> { <simple-template-id> }

        rule class-specifier {
            <class-head>
            <left-brace>
            <member-specification>?
            <right-brace>
        }

        proto rule class-head { * }

        rule class-head:sym<class> {
            <class-key>
            <attribute-specifier-seq>?
            [ <class-head-name> <class-virt-specifier>? ]?
            <base-clause>?
        }

        rule class-head:sym<union> {
            <union>
            <attribute-specifier-seq>?
            [ <class-head-name> <class-virt-specifier>? ]?
        }

        rule class-head-name {
            <nested-name-specifier>?  <class-name>
        }

        rule class-virt-specifier {
            <final>
        }

        proto rule class-key { * }
        rule class-key:sym<class>  { <class_> }
        rule class-key:sym<struct> { <struct> }
    }
}

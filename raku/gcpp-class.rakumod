use Data::Dump::Tree;

use gcpp-roles;
use gcpp-ident;
use gcpp-template;
use gcpp-member;
use gcpp-attr;
use gcpp-base;


# rule class-virt-specifier { 
#   <final> 
# }
our class ClassVirtSpecifier {

    has $.text;

    method gist{
        "final"
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

        my $builder = "";

        if $.nested-name-specifier {
            $builder ~= $.nested-name-specifier.gist;
        }

        $builder ~ $.class-name.gist
    }
}

# rule class-name:sym<id> { <identifier> }
our class ClassName::Id does IClassName {
    has Identifier $.identifier is required;
    has $.text;

    method gist{
        $.identifier.gist
    }
}

# rule class-name:sym<template-id> { <simple-template-id> }
our class ClassName::TemplateId does IClassName {
    has SimpleTemplateId $.simple-template-id is required;
    has $.text;

    method gist{
        $.simple-template-id.gist
    }
}

# rule class-specifier { 
#   <class-head> 
#   <.left-brace> 
#   <member-specification>? 
#   <.right-brace> 
# } #-----------------------------
our class ClassSpecifier { 
    has IClassHead $.class-head is required;
    has MemberSpecification $.member-specification;
    has $.text;

    method gist{

        my $builder = $.class-head.gist ~ " \{\n";

        if $.member-specification {
            $builder ~= $.member-specification.gist;
        }

        $builder ~ "}"
    }
}


# rule class-head:sym<class> { 
#   <.class-key> 
#   <attribute-specifier-seq>? 
#   [ <class-head-name> <class-virt-specifier>? ]? 
#   <base-clause>? 
# }
our class ClassHead::Class does IClassHead {
    has IClassKey              $.class-key is required;
    has IAttributeSpecifierSeq $.attribute-specifier-seq;
    has ClassHeadName          $.class-head-name;
    has ClassVirtSpecifier     $.class-virt-specifier;
    has BaseClause             $.base-clause;

    has $.text;

    method gist{

        my $builder = $.class-key.gist ~ " ";

        if $.attribute-specifier-seq {
            $builder ~= $.attribute-specifier-seq.gist ~ " ";
        }

        if $.class-head-name {
            $builder ~= $.class-head-name.gist ~ " ";

            if $.class-virt-specifier {
                $builder ~= $.class-virt-specifier.gist ~ " ";
            }
        }

        if $.base-clause {
            $builder ~= $.base-clause.gist;
        }

        $builder
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

        my $builder = "union ";

        if $.attribute-specifier-seq {
            $builder ~= $.attribute-specifier-seq.gist;
        }

        if $.class-head-name {

            $builder ~= $.class-head-name.gist ~ " ";

            if $.class-virt-specifier {
                $builder ~= $.class-virt-specifier.gist ~ " ";
            }
        }

        $builder
    }
}


# rule class-key:sym<class> { 
#   <.class_> 
# }
our class ClassKey::Class does IClassKey {

    has $.text;

    method gist{
        "class"
    }
}

# rule class-key:sym<struct> { 
#   <.struct> 
# }
our class ClassKey::Struct does IClassKey { 

    has $.text;

    method gist{
        "struct"
    }
}

our role Class::Actions {

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
        make ClassHead::Class.new(
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
        make ClassHead::Union.new(
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
        make ClassKey::Class.new
    }

    # rule class-key:sym<struct> { <.struct> } 
    method class-key:sym<struct>($/) {
        make ClassKey::Struct.new
    }
}

our role Class::Rules {

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

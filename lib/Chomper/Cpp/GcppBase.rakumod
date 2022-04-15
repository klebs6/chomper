unit module Chomper::Cpp::GcppBase;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;
use Chomper::Cpp::GcppAttr;

# rule base-specifier-list { 
#   <base-specifier> 
#   <ellipsis>? 
#   [ <.comma> <base-specifier> <ellipsis>? ]* 
# } #-----------------------------
class BaseSpecifierList is export { 
    has IBaseSpecifier @.base-specifiers is required;

    has $.text;

    method gist(:$treemark=False) {
        @.base-specifiers>>.gist(:$treemark).join(", ")
    }
}

# rule base-clause { 
#   <colon> 
#   <base-specifier-list> 
# }
class BaseClause is export { 
    has BaseSpecifierList $.base-specifier-list is required;

    has $.text;

    method gist(:$treemark=False) {
        ":" ~ $.base-specifier-list.gist(:$treemark)
    }
}

# rule base-type-specifier { 
#   <class-or-decl-type> 
# }
class BaseTypeSpecifier is export { 
    has IClassOrDeclType $.class-or-decl-type is required;

    method gist(:$treemark=False) {
        $.class-or-decl-type.gist(:$treemark)
    }
}

# rule base-specifier:sym<base-type> { 
#   <attribute-specifier-seq>? 
#   <base-type-specifier> 
# }
class BaseSpecifier::BaseType does IBaseSpecifier is export {
    has IAttributeSpecifierSeq $.attribute-specifier-seq;
    has BaseTypeSpecifier $.base-type-specifier is required;

    has $.text;

    method gist(:$treemark=False) {

        if $.attribute-specifier-seq {
            $.attribute-specifier-seq.gist(:$treemark) ~ " " ~ $.base-type-specifier.gist(:$treemark)

        } else {
            $.base-type-specifier.gist(:$treemark)
        }
    }
}

# rule base-specifier:sym<virtual> { 
#   <attribute-specifier-seq>? 
#   <virtual> 
#   <access-specifier>? 
#   <base-type-specifier> 
# }
class BaseSpecifier::Virtual does IBaseSpecifier is export {
    has IAttributeSpecifierSeq $.attribute-specifier-seq;
    has IAccessSpecifier $.access-specifier;
    has BaseTypeSpecifier $.base-type-specifier is required;

    has $.text;

    method gist(:$treemark=False) {

        my $builder = "";

        if $.attribute-specifier-seq {
            $builder ~= $.attribute-specifier-seq.gist(:$treemark) ~ " ";
        }

        $builder ~= " virtual ";

        if $.access-specifier {
            $builder ~= $.access-specifier.gist(:$treemark);
        }

        $builder ~ $.base-type-specifier.gist(:$treemark)
    }
}

# rule base-specifier:sym<access> { 
#   <attribute-specifier-seq>? 
#   <access-specifier> 
#   <virtual>? 
#   <base-type-specifier> 
# }
class BaseSpecifier::Access does IBaseSpecifier is export {
    has IAttributeSpecifierSeq $.attribute-specifier-seq;
    has IAccessSpecifier       $.access-specifier    is required;
    has Bool                   $.is-virtual          is required;
    has BaseTypeSpecifier      $.base-type-specifier is required;

    has $.text;

    method gist(:$treemark=False) {

        my $builder = "";

        if $.attribute-specifier-seq {
            $builder ~= $.attribute-specifier-seq.gist(:$treemark) ~ " ";
        }

        $builder ~= $.access-specifier.gist(:$treemark) ~ " ";

        if $.is-virtual {
            $builder ~= "virtual ";
        }

        $builder ~ $.base-type-specifier.gist(:$treemark)
    }
}

package BaseGrammar is export {

    our role Actions {

        # rule base-clause { <colon> <base-specifier-list> }
        method base-clause($/) {
            make BaseClause.new(
                base-specifier-list => $<base-specifier-list>.made,
                text                => ~$/,
            )
        }

        # rule base-specifier-list { <base-specifier> <ellipsis>? [ <.comma> <base-specifier> <ellipsis>? ]* } 
        method base-specifier-list($/) {
            make $<base-specifier>>>.made
        }

        # rule base-specifier:sym<base-type> { <attribute-specifier-seq>? <base-type-specifier> }
        method base-specifier:sym<base-type>($/) {

            my $prefix = $<attribute-specifier-seq>.made;
            my $base   = $<base-type-specifier>.made;

            if $prefix {
                make BaseSpecifier::BaseType.new(
                    attribute-specifier-seq => $prefix,
                    base-type-specifier     => $base,
                    text                    => ~$/,
                )
            } else {
                make $base
            }
        }

        # rule base-specifier:sym<virtual> { 
        #   <attribute-specifier-seq>? 
        #   <virtual> 
        #   <access-specifier>? 
        #   <base-type-specifier> 
        # }
        method base-specifier:sym<virtual>($/) {
            make BaseSpecifier::Virtual.new(
                attribute-specifier-seq => $<attribute-specifier-seq>.made,
                access-specifier        => $<access-specifier>.made,
                base-type-specifier     => $<base-type-specifier>.made,
                text                    => ~$/,
            )
        }

        # rule base-specifier:sym<access> { 
        #   <attribute-specifier-seq>? 
        #   <access-specifier> 
        #   <virtual>? 
        #   <base-type-specifier> 
        # } 
        method base-specifier:sym<access>($/) {
            make BaseSpecifier::Access.new(
                attribute-specifier-seq => $<attribute-specifier-seq>.made,
                access-specifier        => $<access-specifier>.made,
                is-virtual              => $<is-virtual>.made,
                base-type-specifier     => $<base-type-specifier>.made,
                text                    => ~$/,
            )
        }

        # rule base-type-specifier { <class-or-decl-type> }
        method base-type-specifier($/) {
            make $<class-or-decl-type>.made
        }
    }

    our role Rules {

        rule base-type-specifier {
            <class-or-decl-type>
        }

        rule base-clause {
            <colon> <base-specifier-list>
        }

        rule base-specifier-list {
            <base-specifier> <ellipsis>?  [ <comma> <base-specifier> <ellipsis>?  ]*
        }

        #-----------------------------
        proto rule base-specifier { * }

        rule base-specifier:sym<base-type> {
            <attribute-specifier-seq>?
            <base-type-specifier>
        }

        rule base-specifier:sym<virtual> {
            <attribute-specifier-seq>?
            <virtual> 
            <access-specifier>? 
            <base-type-specifier>
        }

        rule base-specifier:sym<access> {
            <attribute-specifier-seq>?
            <access-specifier> 
            <virtual>? 
            <base-type-specifier>
        }
    }
}

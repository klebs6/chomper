unit module Chomper::Cpp::GcppPtrOperator;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;
use Chomper::Cpp::GcppAttr;
use Chomper::Cpp::GcppCv;

# rule augmented-pointer-operator { 
#   <pointer-operator> 
#   <const>? 
# }
our class AugmentedPointerOperator does IAugmentedPointerOperator { 
    has IPointerOperator $.pointer-operator is required;
    has Bool             $.const            is required;

    has $.text;

    method gist(:$treemark=False) {
        $.pointer-operator.gist(:$treemark).&maybe-extend(:$treemark,$.const)
    }
}

# rule pointer-operator:sym<ref> { 
#   <and_> 
#   <attribute-specifier-seq>? 
# }
our class PointerOperator::Ref 
does ISomeDeclarator
does IPointerOperator {
    has IAttributeSpecifierSeq $.attribute-specifier-seq;

    has $.text;

    method gist(:$treemark=False) {
        "&".&maybe-extend(:$treemark,$.attribute-specifier-seq)
    }
}

# rule pointer-operator:sym<ref-ref> { 
#   <and-and> 
#   <attribute-specifier-seq>? 
# }
our class PointerOperator::RefRef does IPointerOperator {
    has IAndAnd $.and-and is required;
    has IAttributeSpecifierSeq $.attribute-specifier-seq;

    has $.text;

    method gist(:$treemark=False) {
        "&&".&maybe-extend(:$treemark,$.attribute-specifier-seq)
    }
}

# rule pointer-operator:sym<star> { 
#   <nested-name-specifier>? 
#   <star> 
#   <attribute-specifier-seq>? 
#   <cvqualifierseq>? 
# }
our class PointerOperator::Star does IPointerOperator {
    has INestedNameSpecifier   $.nested-name-specifier;
    has IAttributeSpecifierSeq $.attribute-specifier-seq;
    has Cvqualifierseq        $.cvqualifierseq;

    has $.text;

    method gist(:$treemark=False) {
        my $builder = "";

        $builder = $builder.&maybe-extend(:$treemark,$.nested-name-specifier);

        $builder ~= "*";

        $builder = $builder.&maybe-extend(:$treemark,$.attribute-specifier-seq);
        $builder = $builder.&maybe-extend(:$treemark,$.cvqualifierseq);

        $builder
    }
}

our role PointerOperator::Actions {

    # rule pointer-operator:sym<ref> { 
    #   <and_> 
    #   <attribute-specifier-seq>? 
    # }
    method pointer-operator:sym<ref>($/) {
        make PointerOperator::Ref.new(
            attribute-specifier-seq => $<attribute-specifier-seq>.made,
            text                    => ~$/,
        )
    }

    # rule pointer-operator:sym<ref-ref> { 
    #   <and-and> 
    #   <attribute-specifier-seq>? 
    # }
    method pointer-operator:sym<ref-ref>($/) {
        make PointerOperator::RefRef.new(
            and-and                 => $<and-and>.made,
            attribute-specifier-seq => $<attribute-specifier-seq>.made,
            text                    => ~$/,
        )
    }

    # rule pointer-operator:sym<star> { 
    #   <nested-name-specifier>? 
    #   <star> 
    #   <attribute-specifier-seq>? 
    #   <cvqualifierseq>? 
    # }
    method pointer-operator:sym<star>($/) {
        make PointerOperator::Star.new(
            nested-name-specifier   => $<nested-name-specifier>.made,
            attribute-specifier-seq => $<attribute-specifier-seq>.made,
            cvqualifierseq          => $<cvqualifierseq>.made,
            text                    => ~$/,
        )
    }

    # rule augmented-pointer-operator { 
    #   <pointer-operator> 
    #   <const>? 
    # } 
    method augmented-pointer-operator($/) {

        my $const = $<const>.made;
        my $body  = $<pointer-operator>.made;

        if $const {
            make AugmentedPointerOperator.new(
                pointer-operator => $body,
                const            => $const,
                text             => ~$/,
            )
        } else {
            make $body
        }
    }
}

our role PointerOperator::Rules {

    proto rule pointer-operator { * }

    rule pointer-operator:sym<ref> {
        <and_>
        <attribute-specifier-seq>?
    }

    rule pointer-operator:sym<ref-ref> {
        <and-and>
        <attribute-specifier-seq>?
    }

    rule pointer-operator:sym<star> {
        <nested-name-specifier>?
        <star>
        <attribute-specifier-seq>?
        <cvqualifierseq>?
    }

    rule augmented-pointer-operator {
        <pointer-operator> <const>?
    }
}
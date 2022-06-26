unit module Chomper::Cpp::GcppDeclSpecifier;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;
use Chomper::Cpp::GcppAttr;

package DeclSpecifier is export {

    our class Friend does IDeclSpecifier { 

        method name {
            'DeclSpecifier::Friend'
        }

        method gist {
            "friend"
        }
    }

    our class Typedef does IDeclSpecifier { 

        method name {
            'DeclSpecifier::Typedef'
        }

        method gist {
            "typedef"
        }
    }

    our class Constexpr does IDeclSpecifier { 

        method name {
            'DeclSpecifier::Constexpr'
        }

        method gist {
            "constexpr"
        }
    }
}

# regex decl-specifier-seq { 
#   <decl-specifier> 
#   [<.ws> <decl-specifier>]*? 
#   <attribute-specifier-seq>? 
# }
class DeclSpecifierSeq does IDeclSpecifierSeq is export { 
    has IDeclSpecifier         @.decl-specifiers is required;
    has IAttributeSpecifierSeq $.attribute-specifier-seq;

    has $.text;

    method name {
        'DeclSpecifierSeq'
    }

    method gist(:$treemark=False) {

        my $builder = @.decl-specifiers>>.gist(:$treemark).join(" ");

        my $ass = $.attribute-specifier-seq;

        if $ass {
            $builder ~= " " ~ $ass;
        }

        $builder
    }
}

class CvAuto is export {
    has $.cvqualifierseq;
    has $.storage-class-specifier;

    method name {
        'CvAuto'
    }

    method is-mutable {
        if $.cvqualifierseq {
            $.cvqualifierseq.is-mutable()
        } else {
            True
        }
    }

    method gist(:$treemark=False) {

        my $builder;

        if $.cvqualifierseq {
            $builder ~= $.cvqualifierseq.gist(:$treemark) ~ " ";
        }

        if $.storage-class-specifier {
            $builder ~= $.storage-class-specifier.gist(:$treemark) ~ " ";
        }

        $builder ~ "auto"
    }
}

package DeclSpecifierGrammar is export {

    our role Actions {

        # token decl-specifier:sym<storage-class> { 
        #   <storage-class-specifier> 
        # }
        method decl-specifier:sym<storage-class>($/) {
            make $<storage-class-specifier>.made
        }

        # token decl-specifier:sym<type> { 
        #   <type-specifier> 
        # }
        method decl-specifier:sym<type>($/) {
            make $<type-specifier>.made
        }

        # token decl-specifier:sym<func> { 
        #   <function-specifier> 
        # }
        method decl-specifier:sym<func>($/) {
            make $<function-specifier>.made
        }

        # token decl-specifier:sym<friend> { 
        #   <.friend> 
        # }
        method decl-specifier:sym<friend>($/) {
            make DeclSpecifier::Friend.new
        }

        # token decl-specifier:sym<typedef> { 
        #   <.typedef> 
        # }
        method decl-specifier:sym<typedef>($/) {
            make DeclSpecifier::Typedef.new
        }

        # token decl-specifier:sym<constexpr> { 
        #   <.constexpr> 
        # }
        method decl-specifier:sym<constexpr>($/) {
            make DeclSpecifier::Constexpr.new
        }

        # regex decl-specifier-seq { 
        #   <decl-specifier> 
        #   [<.ws> <decl-specifier>]*? 
        #   <attribute-specifier-seq>? 
        # }
        method decl-specifier-seq($/) {
            my @specifiers = $<decl-specifier>>>.made;
            my $seq        = $<attribute-specifier-seq>.made;

            if @specifiers.elems gt 1 or $seq {
                make DeclSpecifierSeq.new(
                    decl-specifiers         => @specifiers,
                    attribute-specifier-seq => $seq // Nil,
                    text                    => ~$/,
                )
            } else {
                make @specifiers[0]
            }
        }

        method cv-auto($/) {
            make CvAuto.new(
                cvqualifierseq          => $<cvqualifierseq>.made,
                storage-class-specifier => $<storage-class-specifier>.made,
            )
        }
    }

    our role Rules {

        proto rule decltype-specifier-body { * }
        rule decltype-specifier-body:sym<expr> { <expression> }
        rule decltype-specifier-body:sym<auto> { <auto> }

        rule decltype-specifier {
            <decltype>
            <left-paren>
            <decltype-specifier-body>
            <right-paren>
        }

        rule cv-auto {
            <cvqualifierseq>? <storage-class-specifier>? <auto>
        }

        proto token decl-specifier { * }
        token decl-specifier:sym<storage-class> { <storage-class-specifier> }
        token decl-specifier:sym<type>          { <type-specifier> }
        token decl-specifier:sym<func>          { <function-specifier> }
        token decl-specifier:sym<friend>        { <friend> }
        token decl-specifier:sym<typedef>       { <typedef> }
        token decl-specifier:sym<constexpr>     { <constexpr> }

        regex decl-specifier-seq {
            <decl-specifier> [<ws> <decl-specifier>]*?  <attribute-specifier-seq>?  
        }
    }
}

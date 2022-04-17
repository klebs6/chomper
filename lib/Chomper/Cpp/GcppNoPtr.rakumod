unit module Chomper::Cpp::GcppNoPtr;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;
use Chomper::Cpp::GcppAttr;
use Chomper::Cpp::GcppDeclarator;
use Chomper::Cpp::GcppParam;
use Chomper::Cpp::GcppPtrDeclarator;

package NoPointerDeclaratorBase is export {

    # rule no-pointer-declarator-base:sym<base> { 
    #   <declaratorid> 
    #   <attribute-specifier-seq>? 
    # }
    our class Base 
    does IAbstractDeclarator
    does IInitDeclarator
    does INoPointerDeclaratorBase {
        has Declaratorid           $.declaratorid is required;
        has IAttributeSpecifierSeq $.attribute-specifier-seq;

        has $.text;

        method gist(:$treemark=False) {

            my $builder = $.declaratorid.gist(:$treemark);

            my $a = $.attribute-specifier-seq;

            if $a {
                $builder ~= " " ~ $.a.gist(:$treemark);
            }

            $builder
        }
    }

    # rule no-pointer-declarator-base:sym<parens> { 
    #   <.left-paren> 
    #   <pointer-declarator> 
    #   <.right-paren> 
    # }
    our class Parens 
    does IAbstractDeclarator
    does IParameterDeclarationBody
    does IInitDeclarator
    does INoPointerDeclaratorBase {
        has IPointerDeclarator $.pointer-declarator is required;

        has $.text;

        method gist(:$treemark=False) {
            "(" ~ $.pointer-declarator.gist(:$treemark) ~ ")"
        }
    }
}

package NoPointerDeclaratorTail is export {

    # rule no-pointer-declarator-tail:sym<basic> { 
    #   <parameters-and-qualifiers> 
    # }
    our class Basic does INoPointerDeclaratorTail {
        has ParametersAndQualifiers $.parameters-and-qualifiers is required;

        has $.text;

        method gist(:$treemark=False) {
            $.parameters-and-qualifiers.gist(:$treemark)
        }
    }

    # rule no-pointer-declarator-tail:sym<bracketed> { 
    #   <.left-bracket> 
    #   <constant-expression>? 
    #   <.right-bracket> 
    #   <attribute-specifier-seq>? 
    # } #------------------------------
    our class Bracketed does INoPointerDeclaratorTail {
        has IConstantExpression    $.constant-expression;
        has IAttributeSpecifierSeq $.attribute-specifier-seq;

        has $.text;

        method gist(:$treemark=False) {

            my $builder = "[";

            $builder = $builder.&maybe-extend(:$treemark,$.constant-expression);

            $builder ~= "]";

            $builder = $builder.&maybe-extend(:$treemark,$.attribute-specifier-seq);

            $builder
        }
    }
}

# rule no-pointer-declarator { 
#   <no-pointer-declarator-base> 
#   <no-pointer-declarator-tail>* 
# } #------------------------------
class NoPointerDeclarator 
does IPointerDeclarator
does IAbstractDeclarator
does INoPointerDeclarator 
does IInitDeclarator does IDeclarator is export {

    has INoPointerDeclaratorBase $.no-pointer-declarator-base is required;
    has INoPointerDeclaratorTail @.no-pointer-declarator-tail;

    has $.text;

    method token-types {
        my $first 
        = $.no-pointer-declarator-base.WHAT.^name.split("::")[*-1];

        my @tail = do for @.no-pointer-declarator-tail {
            $_.WHAT.^name.split("::")[*-1]
        };

        [$first, |@tail]
    }

    method gist(:$treemark=False) {

        my $builder = $.no-pointer-declarator-base.gist(:$treemark);

        for @.no-pointer-declarator-tail {
            $builder ~= $_.gist(:$treemark);
        }

        $builder
    }
}

package NoPointerDeclaratorGrammar is export {

    our role Actions {

        # rule no-pointer-declarator-base:sym<base> { <declaratorid> <attribute-specifier-seq>? }
        method no-pointer-declarator-base:sym<base>($/) {
            my $base  = $<declaratorid>.made;
            my $maybe = $<attribute-specifier-seq>.made;

            if $maybe {
                make NoPointerDeclaratorBase::Base.new(
                    declaratorid            => $base,
                    attribute-specifier-seq => $maybe,
                    text                    => ~$/,
                )

            } else {
                make $base
            }
        }

        # rule no-pointer-declarator-base:sym<parens> { <.left-paren> <pointer-declarator> <.right-paren> } 
        method no-pointer-declarator-base:sym<parens>($/) {
            make NoPointerDeclaratorBase::Parens.new(
                pointer-declarator => $<pointer-declarator>.made
            )
        }

        # rule no-pointer-declarator-tail:sym<basic> { <parameters-and-qualifiers> }
        method no-pointer-declarator-tail:sym<basic>($/) {
            make $<parameters-and-qualifiers>.made
        }

        # rule no-pointer-declarator-tail:sym<bracketed> { 
        #   <.left-bracket> 
        #   <constant-expression>? 
        #   <.right-bracket> 
        #   <attribute-specifier-seq>? 
        # } 
        method no-pointer-declarator-tail:sym<bracketed>($/) {
            make NoPointerDeclaratorTail::Bracketed.new(
                constant-expression     => $<constant-expression>.made,
                attribute-specifier-seq => $<attribute-specifier-seq>.made,
                text                    => ~$/,
            )
        }

        # rule no-pointer-declarator { <no-pointer-declarator-base> <no-pointer-declarator-tail>* } 
        method no-pointer-declarator($/) {

            my @tail = $<no-pointer-declarator-tail>>>.made;
            my $base = $<no-pointer-declarator-base>.made;

            if @tail.elems gt 0 {

                make NoPointerDeclarator.new(
                    no-pointer-declarator-base => $base,
                    no-pointer-declarator-tail => @tail,
                    text                       => ~$/,
                )

            } else {

                make $base
            }
        }
    }

    our role Rules {

        #applied a transfomation on this rule to
        #prevent infinite loops
        #
        #if we get any bugs downstream come back to
        #this
        rule no-pointer-new-declarator {
            <left-bracket>
            <expression>
            <right-bracket>
            <attribute-specifier-seq>?
            <no-pointer-new-declarator-tail>*
        }

        rule no-pointer-new-declarator-tail {
            <left-bracket>
            <constant-expression>
            <right-bracket>
            <attribute-specifier-seq>?
        }

        proto rule no-pointer-declarator-base { * }
        rule no-pointer-declarator-base:sym<base>   { <declaratorid> <attribute-specifier-seq>? }
        rule no-pointer-declarator-base:sym<parens> { <left-paren> <pointer-declarator> <right-paren> }

        #------------------------------
        proto rule no-pointer-declarator-tail { * }
        rule no-pointer-declarator-tail:sym<basic>     { <parameters-and-qualifiers> }
        rule no-pointer-declarator-tail:sym<bracketed> { 
            <left-bracket> 
            <constant-expression>?  
            <right-bracket> 
            <attribute-specifier-seq>? 
        }

        #------------------------------
        rule no-pointer-declarator {
            <no-pointer-declarator-base>
            <no-pointer-declarator-tail>*
        }
    }
}

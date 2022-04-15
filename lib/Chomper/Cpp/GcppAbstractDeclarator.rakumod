unit module Chomper::Cpp::GcppAbstractDeclarator;

use Chomper::Cpp::GcppRoles;
use Chomper::Cpp::GcppParam;
use Chomper::Cpp::GcppFunction;
use Chomper::Cpp::GcppAttr;

use Data::Dump::Tree;

our class NoPointerAbstractDeclarator              { ... }
our class AbstractPackDeclarator                   { ... }
our class NoPointerAbstractDeclaratorBracketedBase { ... }
our class NoPointerAbstractPackDeclarator          { ... }

package AbstractDeclarator is export {

    # rule abstract-declarator:sym<base> { 
    #   <pointer-abstract-declarator> 
    # }
    our class Base does IAbstractDeclarator {
        has IPointerAbstractDeclarator $.pointer-abstract-declarator is required;

        has $.text;

        method gist(:$treemark=False) {
            $.pointer-abstract-declarator.gist(:$treemark)
        }
    }

    # rule abstract-declarator:sym<aug> { 
    #   <no-pointer-abstract-declarator>? 
    #   <parameters-and-qualifiers> 
    #   <trailing-return-type> 
    # }
    our class Aug does IAbstractDeclarator {
        has NoPointerAbstractDeclarator $.no-pointer-abstract-declarator;
        has ParametersAndQualifiers     $.parameters-and-qualifiers is required;
        has TrailingReturnType          $.trailing-return-type is required;

        has $.text;

        method gist(:$treemark=False) {

            my $builder = "";

            if $.no-pointer-abstract-declarator {
                $builder ~= $.no-pointer-abstract-declarator.gist(:$treemark) ~ " ";
            }

            $builder ~= $.parameters-and-qualifiers.gist(:$treemark) ~ " ";
            $builder ~= $.trailing-return-type.gist(:$treemark);

            $builder
        }
    }

    # rule abstract-declarator:sym<abstract-pack> { 
    #   <abstract-pack-declarator> 
    # }
    our class AbstractPack does IAbstractDeclarator {
        has AbstractPackDeclarator $.abstract-pack-declarator is required;

        has $.text;

        method gist(:$treemark=False) {
            $.abstract-pack-declarator.gist(:$treemark)
        }
    }
}

package PointerAbstractDeclarator is export {

    # rule pointer-abstract-declarator:sym<no-ptr> { 
    #   <no-pointer-abstract-declarator> 
    # }
    our class NoPtr does IPointerAbstractDeclarator {
        has NoPointerAbstractDeclarator $.no-pointer-abstract-declarator is required;

        has $.text;

        method gist(:$treemark=False) {
            $.no-pointer-abstract-declarator.gist(:$treemark)
        }
    }

    # rule pointer-abstract-declarator:sym<ptr> { 
    #   <pointer-operator>+ 
    #   <no-pointer-abstract-declarator>? 
    # }
    our class Ptr does IPointerAbstractDeclarator {
        has IPointerOperator            @.pointer-operators is required;
        has NoPointerAbstractDeclarator $.no-pointer-abstract-declarator;

        has $.text;

        method gist(:$treemark=False) {

            my $builder = @.pointer-operators>>.gist(:$treemark).join(" ");

            if $.no-pointer-abstract-declarator {
                $builder ~= " " ~ $.no-pointer-abstract-declarator.gist(:$treemark)
            }

            $builder
        }
    }
}

package NoPointerAbstractDeclaratorBody is export {

    # rule no-pointer-abstract-declarator-body:sym<base> { 
    #   <parameters-and-qualifiers> 
    # }
    our class Base does INoPointerAbstractDeclaratorBody {

        has ParametersAndQualifiers $.parameters-and-qualifiers is required;

        has $.text;

        method gist(:$treemark=False) {
            $.parameters-and-qualifiers.gist(:$treemark)
        }
    }

    # rule no-pointer-abstract-declarator-body:sym<brack> { 
    #   <no-pointer-abstract-declarator> 
    #   <no-pointer-abstract-declarator-bracketed-base> 
    # }
    our class Brack does INoPointerAbstractDeclaratorBody {

        has NoPointerAbstractDeclarator              $.no-pointer-abstract-declarator is required;
        has NoPointerAbstractDeclaratorBracketedBase $.no-pointer-abstract-declarator-bracketed-base is required;

        has $.text;

        method gist(:$treemark=False) {
            $.no-pointer-abstract-declarator.gist(:$treemark) 
            ~ " " 
            ~ $.no-pointer-abstract-declarator-bracketed-base.gist(:$treemark)
        }
    }
}

# rule no-pointer-abstract-declarator { 
#   <no-pointer-abstract-declarator-base> 
#   <no-pointer-abstract-declarator-body>* 
# } #-----------------------------
class NoPointerAbstractDeclarator is export { 
    has INoPointerAbstractDeclaratorBase $.no-pointer-abstract-declarator-base is required;
    has INoPointerAbstractDeclaratorBody @.no-pointer-abstract-declarator-body is required;

    has $.text;

    method gist(:$treemark=False) {
        $.no-pointer-abstract-declarator-base.gist(:$treemark)
        ~ " "
        ~ @.no-pointer-abstract-declarator-body>>.gist(:$treemark).join(" ")
    }
}

package NoPointerAbstractDeclaratorBase is export {

    # rule no-pointer-abstract-declarator-base:sym<basic> { 
    #   <parameters-and-qualifiers> 
    # }
    our class Basic does INoPointerAbstractDeclaratorBase {

        has ParametersAndQualifiers $.parameters-and-qualifiers is required;

        has $.text;

        method gist(:$treemark=False) {
            $.parameters-and-qualifiers.gist(:$treemark)
        }
    }

    # rule no-pointer-abstract-declarator-base:sym<bracketed> { 
    #   <no-pointer-abstract-declarator-bracketed-base> 
    # }
    our class Bracketed does INoPointerAbstractDeclaratorBase {

        has NoPointerAbstractDeclaratorBracketedBase $.no-pointer-abstract-declarator-bracketed-base is required;

        has $.text;

        method gist(:$treemark=False) {
            $.no-pointer-abstract-declarator-bracketed-base.gist(:$treemark)
        }
    }

    # rule no-pointer-abstract-declarator-base:sym<parenthesized> { 
    #   <.left-paren> 
    #   <pointer-abstract-declarator> 
    #   <.right-paren> 
    # }
    our class Parenthesized does INoPointerAbstractDeclaratorBase {

        has IPointerAbstractDeclarator $.pointer-abstract-declarator is required;

        has $.text;

        method gist(:$treemark=False) {
            "(" ~ $.pointer-abstract-declarator.gist(:$treemark) ~ ")"
        }
    }
}

# rule no-pointer-abstract-declarator-bracketed-base { 
#   <.left-bracket> 
#   <constant-expression>? 
#   <.right-bracket> 
#   <attribute-specifier-seq>? 
# }
class NoPointerAbstractDeclaratorBracketedBase 
does IParameterDeclarationBody 
does IAbstractDeclarator is export { 

    has IConstantExpression    $.constant-expression;
    has IAttributeSpecifierSeq $.attribute-specifier-seq;

    has $.text;

    method gist(:$treemark=False) {
        my $builder = "";

        $builder ~= "[";

        if $.constant-expression {
            $builder ~= $.constant-expression.gist(:$treemark);
        }

        $builder ~= "]";

        if $.attribute-specifier-seq {
            $builder ~= $.attribute-specifier-seq.gist(:$treemark);
        }

        $builder
    }
}

# rule abstract-pack-declarator { 
#   <pointer-operator>* 
#   <no-pointer-abstract-pack-declarator> 
# }
class AbstractPackDeclarator is export { 
    has IPointerOperator                @.pointer-operators is required;
    has NoPointerAbstractPackDeclarator $.no-pointer-abstract-pack-declarator is required;

    has $.text;

    method gist(:$treemark=False) {
        @.pointer-operators>>.gist(:$treemark).join(" ") ~ $.no-pointer-abstract-pack-declarator.gist(:$treemark)
    }
}

# rule no-pointer-abstract-pack-declarator-basic { 
#   <parameters-and-qualifiers> 
# }
class NoPointerAbstractPackDeclaratorBasic is export { 
    has ParametersAndQualifiers $.parameters-and-qualifiers is required;

    has $.text;

    method gist(:$treemark=False) {
        $.parameters-and-qualifiers.gist(:$treemark)
    }
}

# rule no-pointer-abstract-pack-declarator-brackets { 
#   <.left-bracket> 
#   <constant-expression>? 
#   <.right-bracket> 
#   <attribute-specifier-seq>? 
# }
class NoPointerAbstractPackDeclaratorBrackets is export { 
    has IConstantExpression    $.constant-expression;
    has IAttributeSpecifierSeq $.attribute-specifier-seq;

    has $.text;

    method gist(:$treemark=False) {

        my $builder = "[";

        if $.constant-expression {
            $builder ~= $.constant-expression.gist(:$treemark);
        }

        $builder ~= "]";

        if $.attribute-specifier-seq {
            $builder ~= $.attribute-specifier-seq.gist(:$treemark);
        }

        $builder
    }
}

package NoPointerAbstractPackDeclaratorBody is export {

    # rule no-pointer-abstract-pack-declarator-body:sym<basic> { 
    #   <no-pointer-abstract-pack-declarator-basic> 
    # }
    our class Basic does INoPointerAbstractPackDeclaratorBody {

        has NoPointerAbstractPackDeclaratorBasic $.no-pointer-abstract-pack-declarator-basic is required;

        has $.text;

        method gist(:$treemark=False) {
            $.no-pointer-abstract-pack-declarator-basic.gist(:$treemark)
        }
    }

    # rule no-pointer-abstract-pack-declarator-body:sym<brack> { 
    #   <no-pointer-abstract-pack-declarator-brackets> 
    # }
    our class Brack does INoPointerAbstractPackDeclaratorBody {

        has NoPointerAbstractPackDeclaratorBrackets $.no-pointer-abstract-pack-declarator-brackets is required;

        has $.text;

        method gist(:$treemark=False) {
            $.no-pointer-abstract-pack-declarator-brackets.gist(:$treemark)
        }
    }
}

# rule no-pointer-abstract-pack-declarator { 
#   <ellipsis> 
#   <no-pointer-abstract-pack-declarator-body>* 
# }
class NoPointerAbstractPackDeclarator is export { 
    has INoPointerAbstractPackDeclaratorBody @.no-pointer-abstract-pack-declarator-bodies is required;

    has $.text;

    method gist(:$treemark=False) {
        "..." ~ @.no-pointer-abstract-pack-declarator-bodies>>.gist(:$treemark).join(" ")
    }
}

package AbstractDeclaratorGrammar is export {

    our role Actions {

        # rule abstract-declarator:sym<base> { <pointer-abstract-declarator> }
        method abstract-declarator:sym<base>($/) {
            make $<pointer-abstract-declarator>.made
        }

        # rule abstract-declarator:sym<aug> { <no-pointer-abstract-declarator>? <parameters-and-qualifiers> <trailing-return-type> }
        method abstract-declarator:sym<aug>($/) {
            make AbstractDeclarator::Aug.new(
                no-pointer-abstract-declarator => $<no-pointer-abstract-declarator>.made,
                parameters-and-qualifiers      => $<parameters-and-qualifiers>.made,
                trailing-return-type           => $<trailing-return-type>.made,
                text                           => ~$/,
            )
        }

        # rule abstract-declarator:sym<abstract-pack> { <abstract-pack-declarator> } 
        method abstract-declarator:sym<abstract-pack>($/) {
            make $<abstract-pack-declarator>.made
        }

        # rule pointer-abstract-declarator:sym<no-ptr> { <no-pointer-abstract-declarator> }
        method pointer-abstract-declarator:sym<no-ptr>($/) {
            make $<no-pointer-abstract-declarator>.made
        }

        # rule pointer-abstract-declarator:sym<ptr> { <pointer-operator>+ <no-pointer-abstract-declarator>? } 
        method pointer-abstract-declarator:sym<ptr>($/) {
            my @ops  = $<pointer-operator>>>.made;
            my $tail = $<no-pointer-abstract-declarator>.made;

            if $tail or @ops.elems gt 1 {
                make PointerAbstractDeclarator::Ptr.new(
                    pointer-operators              => @ops,
                    no-pointer-abstract-declarator => $tail,
                )
            } else {
                make @ops[0]
            }
        }

        # rule no-pointer-abstract-declarator-body:sym<base> { <parameters-and-qualifiers> }
        method no-pointer-abstract-declarator-body:sym<base>($/) {
            make $<parameters-and-qualifiers>.made
        }

        # rule no-pointer-abstract-declarator-body:sym<brack> { <no-pointer-abstract-declarator> <no-pointer-abstract-declarator-bracketed-base> }
        method no-pointer-abstract-declarator-body:sym<brack>($/) {
            make NoPointerAbstractDeclaratorBody::Brack.new(
                no-pointer-abstract-declarator                => $<no-pointer-abstract-declarator>.made,
                no-pointer-abstract-declarator-bracketed-base => $<no-pointer-abstract-declarator-bracketed-base>.made,
            )
        }

        # rule no-pointer-abstract-declarator { <no-pointer-abstract-declarator-base> <no-pointer-abstract-declarator-body>* } 
        method no-pointer-abstract-declarator($/) {

            my $base = $<no-pointer-abstract-declarator-base>.made;
            my @body = $<no-pointer-abstract-declarator-body>>>.made;

            if @body.elems gt 0 {
                make NoPointerAbstractDeclarator.new(
                    no-pointer-abstract-declarator-base => $base,
                    no-pointer-abstract-declarator-body => @body,
                )
            } else {
                make $base
            }
        }

        # rule no-pointer-abstract-declarator-base:sym<basic> { <parameters-and-qualifiers> }
        method no-pointer-abstract-declarator-base:sym<basic>($/) {
            make $<parameters-and-qualifiers>.made
        }

        # rule no-pointer-abstract-declarator-base:sym<bracketed> { <no-pointer-abstract-declarator-bracketed-base> }
        method no-pointer-abstract-declarator-base:sym<bracketed>($/) {
            make $<no-pointer-abstract-declarator-bracketed-base>.made
        }

        # rule no-pointer-abstract-declarator-base:sym<parenthesized> { <.left-paren> <pointer-abstract-declarator> <.right-paren> }
        method no-pointer-abstract-declarator-base:sym<parenthesized>($/) {
            make $<pointer-abstract-declarator>.made
        }

        # rule no-pointer-abstract-declarator-bracketed-base { 
        #   <.left-bracket> 
        #   <constant-expression>? 
        #   <.right-bracket> 
        #   <attribute-specifier-seq>? 
        # }
        method no-pointer-abstract-declarator-bracketed-base($/) {
            make NoPointerAbstractDeclaratorBracketedBase.new(
                constant-expression     => $<constant-expression>.made,
                attribute-specifier-seq => $<attribute-specifier-seq>.made,
            )
        }

        # rule abstract-pack-declarator { <pointer-operator>* <no-pointer-abstract-pack-declarator> } 
        method abstract-pack-declarator($/) {

            my @ops  = $<pointer-operator>>>.made;
            my $body = $<no-pointer-abstract-pack-declarator>.made;

            if @ops.elems gt 0 {
                make AbstractPackDeclarator.new(
                    pointer-operators                   => @ops,
                    no-pointer-abstract-pack-declarator => $body,
                )

            } else {

                make $body
            }
        }

        # rule no-pointer-abstract-pack-declarator-basic { <parameters-and-qualifiers> }
        method no-pointer-abstract-pack-declarator-basic($/) {
            make $<parameters-and-qualifiers>.made
        }

        # rule no-pointer-abstract-pack-declarator-brackets { 
        #   <.left-bracket> 
        #   <constant-expression>? 
        #   <.right-bracket> 
        #   <attribute-specifier-seq>? 
        # } 
        method no-pointer-abstract-pack-declarator-brackets($/) {
            make NoPointerAbstractPackDeclaratorBrackets.new(
                constant-expression     => $<constant-expression>.made,
                attribute-specifier-seq => $<attribute-specifier-seq>.made,
            )
        }

        # rule no-pointer-abstract-pack-declarator-body:sym<basic> { <no-pointer-abstract-pack-declarator-basic> }
        method no-pointer-abstract-pack-declarator-body:sym<basic>($/) {
            make $<no-pointer-abstract-pack-declarator-basic>.made
        }

        # rule no-pointer-abstract-pack-declarator-body:sym<brack> { <no-pointer-abstract-pack-declarator-brackets> } 
        method no-pointer-abstract-pack-declarator-body:sym<brack>($/) {
            make $<no-pointer-abstract-pack-declarator-brackets>.made
        }

        # rule no-pointer-abstract-pack-declarator { <ellipsis> <no-pointer-abstract-pack-declarator-body>* }
        method no-pointer-abstract-pack-declarator($/) {
            make $<no-pointer-abstract-pack-declarator-body>>>.made
        }
    }

    our role Rules {

        proto rule abstract-declarator { * }

        rule abstract-declarator:sym<base> {
            <pointer-abstract-declarator>
        }

        rule abstract-declarator:sym<aug> {
            <no-pointer-abstract-declarator>? <parameters-and-qualifiers> <trailing-return-type>
        }

        rule abstract-declarator:sym<abstract-pack> {
            <abstract-pack-declarator>
        }

        #-----------------------------
        proto rule pointer-abstract-declarator { * }
        rule pointer-abstract-declarator:sym<no-ptr> { <no-pointer-abstract-declarator> }
        rule pointer-abstract-declarator:sym<ptr>    { <pointer-operator>+ <no-pointer-abstract-declarator>? }

        #-----------------------------
        proto rule no-pointer-abstract-declarator-body { * }

        rule no-pointer-abstract-declarator-body:sym<base> {
            <parameters-and-qualifiers>
        }

        rule no-pointer-abstract-declarator-body:sym<brack> {
            <no-pointer-abstract-declarator> <no-pointer-abstract-declarator-bracketed-base>
        }

        rule no-pointer-abstract-declarator {
            <no-pointer-abstract-declarator-base>
            <no-pointer-abstract-declarator-body>*
        }

        #-----------------------------
        proto rule no-pointer-abstract-declarator-base { * }
        rule no-pointer-abstract-declarator-base:sym<basic>         { <parameters-and-qualifiers> }
        rule no-pointer-abstract-declarator-base:sym<bracketed>     { <no-pointer-abstract-declarator-bracketed-base> }
        rule no-pointer-abstract-declarator-base:sym<parenthesized> { 
            <left-paren> 
            <pointer-abstract-declarator> 
            <right-paren> 
        }

        rule no-pointer-abstract-declarator-bracketed-base {
            <left-bracket> 
            <constant-expression>?  
            <right-bracket> 
            <attribute-specifier-seq>?
        }

        rule abstract-pack-declarator {
            <pointer-operator>* 
            <no-pointer-abstract-pack-declarator>
        }

        #-----------------------------
        rule no-pointer-abstract-pack-declarator-basic {
            <parameters-and-qualifiers>
        }

        rule no-pointer-abstract-pack-declarator-brackets {
            <left-bracket> 
            <constant-expression>?  
            <right-bracket> 
            <attribute-specifier-seq>?
        }

        #-----------------------------
        proto rule no-pointer-abstract-pack-declarator-body { * }
        rule no-pointer-abstract-pack-declarator-body:sym<basic> { <no-pointer-abstract-pack-declarator-basic> }
        rule no-pointer-abstract-pack-declarator-body:sym<brack> { <no-pointer-abstract-pack-declarator-brackets> }

        #-----------------------------
        rule no-pointer-abstract-pack-declarator {
            <ellipsis>
            <no-pointer-abstract-pack-declarator-body>*
        }
    }
}

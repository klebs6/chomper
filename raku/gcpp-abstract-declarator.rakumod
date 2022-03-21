use gcpp-roles;
use gcpp-param;
use gcpp-function;
use gcpp-attr;

use Data::Dump::Tree;

our class NoPointerAbstractDeclarator              { ... }
our class AbstractPackDeclarator                   { ... }
our class NoPointerAbstractDeclaratorBracketedBase { ... }
our class NoPointerAbstractPackDeclarator          { ... }

# rule abstract-declarator:sym<base> { 
#   <pointer-abstract-declarator> 
# }
our class AbstractDeclarator::Base does IAbstractDeclarator {
    has IPointerAbstractDeclarator $.pointer-abstract-declarator is required;

    has $.text;

    method gist{
        $.pointer-abstract-declarator.gist
    }
}

# rule abstract-declarator:sym<aug> { 
#   <no-pointer-abstract-declarator>? 
#   <parameters-and-qualifiers> 
#   <trailing-return-type> 
# }
our class AbstractDeclarator::Aug does IAbstractDeclarator {
    has NoPointerAbstractDeclarator $.no-pointer-abstract-declarator;
    has ParametersAndQualifiers     $.parameters-and-qualifiers is required;
    has TrailingReturnType          $.trailing-return-type is required;

    has $.text;

    method gist{

        my $builder = "";

        if $.no-pointer-abstract-declarator {
            $builder ~= $.no-pointer-abstract-declarator.gist ~ " ";
        }

        $builder ~= $.parameters-and-qualifiers.gist ~ " ";
        $builder ~= $.trailing-return-type.gist;

        $builder
    }
}

# rule abstract-declarator:sym<abstract-pack> { 
#   <abstract-pack-declarator> 
# }
our class AbstractDeclarator::AbstractPack does IAbstractDeclarator {
    has AbstractPackDeclarator $.abstract-pack-declarator is required;

    has $.text;

    method gist{
        $.abstract-pack-declarator.gist
    }
}

# rule pointer-abstract-declarator:sym<no-ptr> { 
#   <no-pointer-abstract-declarator> 
# }
our class PointerAbstractDeclarator::NoPtr does IPointerAbstractDeclarator {
    has NoPointerAbstractDeclarator $.no-pointer-abstract-declarator is required;

    has $.text;

    method gist{
        $.no-pointer-abstract-declarator.gist
    }
}

# rule pointer-abstract-declarator:sym<ptr> { 
#   <pointer-operator>+ 
#   <no-pointer-abstract-declarator>? 
# }
our class PointerAbstractDeclarator::Ptr does IPointerAbstractDeclarator {
    has IPointerOperator            @.pointer-operators is required;
    has NoPointerAbstractDeclarator $.no-pointer-abstract-declarator;

    has $.text;

    method gist{

        my $builder = @.pointer-operators>>.gist.join(" ");

        if $.no-pointer-abstract-declarator {
            $builder ~= " " ~ $.no-pointer-abstract-declarator.gist
        }

        $builder
    }
}

# rule no-pointer-abstract-declarator-body:sym<base> { 
#   <parameters-and-qualifiers> 
# }
our class NoPointerAbstractDeclaratorBody::Base 
does INoPointerAbstractDeclaratorBody {

    has ParametersAndQualifiers $.parameters-and-qualifiers is required;

    has $.text;

    method gist{
        $.parameters-and-qualifiers.gist
    }
}

# rule no-pointer-abstract-declarator-body:sym<brack> { 
#   <no-pointer-abstract-declarator> 
#   <no-pointer-abstract-declarator-bracketed-base> 
# }
our class NoPointerAbstractDeclaratorBody::Brack 
does INoPointerAbstractDeclaratorBody {

    has NoPointerAbstractDeclarator              $.no-pointer-abstract-declarator is required;
    has NoPointerAbstractDeclaratorBracketedBase $.no-pointer-abstract-declarator-bracketed-base is required;

    has $.text;

    method gist{
        $.no-pointer-abstract-declarator.gist 
        ~ " " 
        ~ $.no-pointer-abstract-declarator-bracketed-base.gist
    }
}

# rule no-pointer-abstract-declarator { 
#   <no-pointer-abstract-declarator-base> 
#   <no-pointer-abstract-declarator-body>* 
# } #-----------------------------
our class NoPointerAbstractDeclarator { 
    has INoPointerAbstractDeclaratorBase $.no-pointer-abstract-declarator-base is required;
    has INoPointerAbstractDeclaratorBody @.no-pointer-abstract-declarator-body is required;

    has $.text;

    method gist{
        $.no-pointer-abstract-declarator-base.gist
        ~ " "
        ~ @.no-pointer-abstract-declarator-body>>.gist.join(" ")
    }
}

# rule no-pointer-abstract-declarator-base:sym<basic> { 
#   <parameters-and-qualifiers> 
# }
our class NoPointerAbstractDeclaratorBase::Basic 
does INoPointerAbstractDeclaratorBase {

    has ParametersAndQualifiers $.parameters-and-qualifiers is required;

    has $.text;

    method gist{
        $.parameters-and-qualifiers.gist
    }
}

# rule no-pointer-abstract-declarator-base:sym<bracketed> { 
#   <no-pointer-abstract-declarator-bracketed-base> 
# }
our class NoPointerAbstractDeclaratorBase::Bracketed 
does INoPointerAbstractDeclaratorBase {

    has NoPointerAbstractDeclaratorBracketedBase $.no-pointer-abstract-declarator-bracketed-base is required;

    has $.text;

    method gist{
        $.no-pointer-abstract-declarator-bracketed-base.gist
    }
}

# rule no-pointer-abstract-declarator-base:sym<parenthesized> { 
#   <.left-paren> 
#   <pointer-abstract-declarator> 
#   <.right-paren> 
# }
our class NoPointerAbstractDeclaratorBase::Parenthesized 
does INoPointerAbstractDeclaratorBase {

    has IPointerAbstractDeclarator $.pointer-abstract-declarator is required;

    has $.text;

    method gist{
        "(" ~ $.pointer-abstract-declarator.gist ~ ")"
    }
}

# rule no-pointer-abstract-declarator-bracketed-base { 
#   <.left-bracket> 
#   <constant-expression>? 
#   <.right-bracket> 
#   <attribute-specifier-seq>? 
# }
our class NoPointerAbstractDeclaratorBracketedBase 
does IAbstractDeclarator
{ 
    has IConstantExpression    $.constant-expression;
    has IAttributeSpecifierSeq $.attribute-specifier-seq;

    has $.text;

    method gist{
        my $builder = "";

        $builder ~= "[";

        if $.constant-expression {
            $builder ~= $.constant-expression.gist;
        }

        $builder ~= "]";

        if $.attribute-specifier-seq {
            $builder ~= $.attribute-specifier-seq.gist;
        }

        $builder
    }
}

# rule abstract-pack-declarator { 
#   <pointer-operator>* 
#   <no-pointer-abstract-pack-declarator> 
# }
our class AbstractPackDeclarator { 
    has IPointerOperator                @.pointer-operators is required;
    has NoPointerAbstractPackDeclarator $.no-pointer-abstract-pack-declarator is required;

    has $.text;

    method gist{
        @.pointer-operators>>.gist.join(" ") ~ $.no-pointer-abstract-pack-declarator.gist
    }
}

# rule no-pointer-abstract-pack-declarator-basic { 
#   <parameters-and-qualifiers> 
# }
our class NoPointerAbstractPackDeclaratorBasic { 
    has ParametersAndQualifiers $.parameters-and-qualifiers is required;

    has $.text;

    method gist{
        $.parameters-and-qualifiers.gist
    }
}

# rule no-pointer-abstract-pack-declarator-brackets { 
#   <.left-bracket> 
#   <constant-expression>? 
#   <.right-bracket> 
#   <attribute-specifier-seq>? 
# }
our class NoPointerAbstractPackDeclaratorBrackets { 
    has IConstantExpression    $.constant-expression;
    has IAttributeSpecifierSeq $.attribute-specifier-seq;

    has $.text;

    method gist{

        my $builder = "[";

        if $.constant-expression {
            $builder ~= $.constant-expression.gist;
        }

        $builder ~= "]";

        if $.attribute-specifier-seq {
            $builder ~= $.attribute-specifier-seq.gist;
        }

        $builder
    }
}

# rule no-pointer-abstract-pack-declarator-body:sym<basic> { 
#   <no-pointer-abstract-pack-declarator-basic> 
# }
our class NoPointerAbstractPackDeclaratorBody::Basic does INoPointerAbstractPackDeclaratorBody {
    has NoPointerAbstractPackDeclaratorBasic $.no-pointer-abstract-pack-declarator-basic is required;

    has $.text;

    method gist{
        $.no-pointer-abstract-pack-declarator-basic.gist
    }
}

# rule no-pointer-abstract-pack-declarator-body:sym<brack> { 
#   <no-pointer-abstract-pack-declarator-brackets> 
# }
our class NoPointerAbstractPackDeclaratorBody::Brack does INoPointerAbstractPackDeclaratorBody {
    has NoPointerAbstractPackDeclaratorBrackets $.no-pointer-abstract-pack-declarator-brackets is required;

    has $.text;

    method gist{
        $.no-pointer-abstract-pack-declarator-brackets.gist
    }
}

# rule no-pointer-abstract-pack-declarator { 
#   <ellipsis> 
#   <no-pointer-abstract-pack-declarator-body>* 
# }
our class NoPointerAbstractPackDeclarator { 
    has INoPointerAbstractPackDeclaratorBody @.no-pointer-abstract-pack-declarator-bodies is required;

    has $.text;

    method gist{
        "..." ~ @.no-pointer-abstract-pack-declarator-bodies>>.gist.join(" ")
    }
}

our role AbstractDeclarator::Actions {

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

our role AbstractDeclarator::Rules {

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

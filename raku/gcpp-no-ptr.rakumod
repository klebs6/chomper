use Data::Dump::Tree;

use gcpp-roles;
use gcpp-attr;
use gcpp-declarator;
use gcpp-param;
use gcpp-ptr-declarator;

# rule no-pointer-declarator-base:sym<base> { 
#   <declaratorid> 
#   <attribute-specifier-seq>? 
# }
our class NoPointerDeclaratorBase::Base does INoPointerDeclaratorBase {
    has Declaratorid           $.declaratorid is required;
    has IAttributeSpecifierSeq $.attribute-specifier-seq;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule no-pointer-declarator-base:sym<parens> { 
#   <.left-paren> 
#   <pointer-declarator> 
#   <.right-paren> 
# }
our class NoPointerDeclaratorBase::Parens does INoPointerDeclaratorBase {
    has PointerDeclarator $.pointer-declarator is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule no-pointer-declarator-tail:sym<basic> { 
#   <parameters-and-qualifiers> 
# }
our class NoPointerDeclaratorTail::Basic does INoPointerDeclaratorTail {
    has ParametersAndQualifiers $.parameters-and-qualifiers is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule no-pointer-declarator-tail:sym<bracketed> { 
#   <.left-bracket> 
#   <constant-expression>? 
#   <.right-bracket> 
#   <attribute-specifier-seq>? 
# } #------------------------------
our class NoPointerDeclaratorTail::Bracketed does INoPointerDeclaratorTail {
    has IConstantExpression    $.constant-expression;
    has IAttributeSpecifierSeq $.attribute-specifier-seq;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}


# rule no-pointer-declarator { 
#   <no-pointer-declarator-base> 
#   <no-pointer-declarator-tail>* 
# } #------------------------------
our class NoPointerDeclarator 
does INoPointerDeclarator 
does IInitDeclarator does IDeclarator {

    has INoPointerDeclaratorBase $.no-pointer-declarator-base is required;
    has INoPointerDeclaratorTail @.no-pointer-declarator-tail;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our role NoPointerDeclarator::Actions {

    # rule no-pointer-declarator-base:sym<base> { <declaratorid> <attribute-specifier-seq>? }
    method no-pointer-declarator-base:sym<base>($/) {
        my $base  = $<declaratorid>.made;
        my $maybe = $<attribute-specifier-seq>.made;

        if $maybe {
            make NoPointerDeclaratorBase::Base.new(
                declaratorid            => $base,
                attribute-specifier-seq => $maybe,
            )

        } else {
            make $base
        }
    }

    # rule no-pointer-declarator-base:sym<parens> { <.left-paren> <pointer-declarator> <.right-paren> } 
    method no-pointer-declarator-base:sym<parens>($/) {
        make $<pointer-declarator>.made
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
            )

        } else {

            make $base
        }
    }
}

our role NoPointerDeclarator::Rules {

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

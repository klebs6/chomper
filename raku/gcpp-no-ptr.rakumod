
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


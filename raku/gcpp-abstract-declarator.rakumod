

# rule abstract-declarator:sym<base> { <pointer-abstract-declarator> }
our class AbstractDeclarator::Base does IAbstractDeclarator {
    has IPointerAbstractDeclarator $.pointer-abstract-declarator is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
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
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule abstract-declarator:sym<abstract-pack> { 
#   <abstract-pack-declarator> 
# }
our class AbstractDeclarator::AbstractPack does IAbstractDeclarator {
    has AbstractPackDeclarator $.abstract-pack-declarator is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule pointer-abstract-declarator:sym<no-ptr> { 
#   <no-pointer-abstract-declarator> 
# }
our class PointerAbstractDeclarator::NoPtr does IPointerAbstractDeclarator {
    has NoPointerAbstractDeclarator $.no-pointer-abstract-declarator is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule pointer-abstract-declarator:sym<ptr> { 
#   <pointer-operator>+ 
#   <no-pointer-abstract-declarator>? 
# }
our class PointerAbstractDeclarator::Ptr does IPointerAbstractDeclarator {
    has IPointerOperator @.pointer-operators is required;
    has NoPointerAbstractDeclarator $.no-pointer-abstract-declarator;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
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
        say "need write gist!";
        ddt self;
        exit;
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
        say "need write gist!";
        ddt self;
        exit;
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
        say "need write gist!";
        ddt self;
        exit;
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
        say "need write gist!";
        ddt self;
        exit;
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
        say "need write gist!";
        ddt self;
        exit;
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
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule no-pointer-abstract-declarator-bracketed-base { 
#   <.left-bracket> 
#   <constant-expression>? 
#   <.right-bracket> 
#   <attribute-specifier-seq>? 
# }
our class NoPointerAbstractDeclaratorBracketedBase { 
    has IConstantExpression    $.constant-expression;
    has IAttributeSpecifierSeq $.attribute-specifier-seq;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
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
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule no-pointer-abstract-pack-declarator-basic { 
#   <parameters-and-qualifiers> 
# }
our class NoPointerAbstractPackDeclaratorBasic { 
    has ParametersAndQualifiers $.parameters-and-qualifiers is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
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
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule no-pointer-abstract-pack-declarator-body:sym<basic> { 
#   <no-pointer-abstract-pack-declarator-basic> 
# }
our class NoPointerAbstractPackDeclaratorBody::Basic does INoPointerAbstractPackDeclaratorBody {
    has NoPointerAbstractPackDeclaratorBasic $.no-pointer-abstract-pack-declarator-basic is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule no-pointer-abstract-pack-declarator-body:sym<brack> { 
#   <no-pointer-abstract-pack-declarator-brackets> 
# }
our class NoPointerAbstractPackDeclaratorBody::Brack does INoPointerAbstractPackDeclaratorBody {
    has NoPointerAbstractPackDeclaratorBrackets $.no-pointer-abstract-pack-declarator-brackets is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
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
        say "need write gist!";
        ddt self;
        exit;
    }
}

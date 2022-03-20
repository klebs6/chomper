
# rule init-declarator { 
#   <declarator> 
#   <initializer>? 
# }
our class InitDeclarator does IInitDeclarator { 
    has IDeclarator  $.declarator is required;
    has IInitializer $.initializer;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}


# rule declarator:sym<ptr> { <pointer-declarator> }
our class Declarator::Ptr does IDeclarator {
    has PointerDeclarator $.pointer-declarator is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule declarator:sym<no-ptr> { 
#   <no-pointer-declarator> 
#   <parameters-and-qualifiers> 
#   <trailing-return-type> 
# }
our class Declarator::NoPtr does IDeclarator {
    has INoPointerDeclarator    $.no-pointer-declarator     is required;
    has ParametersAndQualifiers $.parameters-and-qualifiers is required;
    has TrailingReturnType      $.trailing-return-type      is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule declaratorid { 
#   <ellipsis>? 
#   <id-expression> 
# }
our class Declaratorid 
does INoPointerDeclaratorBase { 

    has Bool         $.has-ellipsis  is required;
    has IIdExpression $.id-expression is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule some-declarator:sym<basic> { 
#   <declarator> 
# }
our class SomeDeclarator::Basic does ISomeDeclarator {
    has IDeclarator $.declarator is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule some-declarator:sym<abstract> { 
#   <abstract-declarator> 
# }
our class SomeDeclarator::Abstract does ISomeDeclarator {
    has IAbstractDeclarator $.abstract-declarator is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule parameters-and-qualifiers { 
#   <.left-paren> 
#   <parameter-declaration-clause>? 
#   <.right-paren> 
#   <cvqualifierseq>? 
#   <refqualifier>? 
#   <exception-specification>? 
#   <attribute-specifier-seq>? 
# }
our class ParametersAndQualifiers 
does INoPointerDeclaratorTail {

    has ParameterDeclarationClause $.parameter-declaration-clause;
    has Cvqualifierseq             $.cvqualifierseq;
    has IRefqualifier               $.refqualifier;
    has IExceptionSpecification     $.exception-specification;
    has IAttributeSpecifierSeq      $.attribute-specifier-seq;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule parameter-declaration-clause { 
#   <parameter-declaration-list> 
#   [ <.comma>? <ellipsis> ]? 
# }
# rule parameter-declaration-list { 
#   <parameter-declaration> 
#   [ <.comma> <parameter-declaration> ]* 
# } #-----------------------------
our class ParameterDeclarationClause { 
    has ParameterDeclaration @.parameter-declaration-list is required;
    has Bool                 $.has-ellipsis is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule parameter-declaration-body:sym<decl> { <declarator> }
our class ParameterDeclarationBody::Decl does IParameterDeclarationBody {
    has IDeclarator $.declarator is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule parameter-declaration-body:sym<abst> { <abstract-declarator>? }
our class ParameterDeclarationBody::Abst does IParameterDeclarationBody {
    has IAbstractDeclarator $.abstract-declarator;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule parameter-declaration { 
#   <attribute-specifier-seq>? 
#   <decl-specifier-seq> 
#   <parameter-declaration-body> 
#   [ <assign> <initializer-clause> ]? 
# }
our class ParameterDeclaration { 
    has IAttributeSpecifierSeq    $.attribute-specifier-seq;
    has IDeclSpecifierSeq         $.decl-specifier-seq is required;
    has IParameterDeclarationBody $.parameter-declaration-body is required;
    has IInitializerClause        $.initializer-clause;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

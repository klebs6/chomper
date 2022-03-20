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

our role Parameters::Actions {

    # rule parameters-and-qualifiers { 
    #   <.left-paren> 
    #   <parameter-declaration-clause>? 
    #   <.right-paren> 
    #   <cvqualifierseq>? 
    #   <refqualifier>? 
    #   <exception-specification>? 
    #   <attribute-specifier-seq>? 
    # j}
    method parameters-and-qualifiers($/) {
        make ParametersAndQualifiers.new(
            parameter-declaration-clause => $<parameter-declaration-clause>.made,
            cvqualifierseq               => $<cvqualifierseq>.made,
            refqualifier                 => $<refqualifier>.made,
            exception-specification      => $<exception-specification>.made,
            attribute-specifier-seq      => $<attribute-specifier-seq>.made,
        )
    }

    # rule parameter-declaration-clause { <parameter-declaration-list> [ <.comma>? <ellipsis> ]? }
    method parameter-declaration-clause($/) {
        make ParameterDeclarationClause.new(
            parameter-declaration-list => $<parameter-declaration-list>.made,
            has-ellipsis               => $<has-ellipsis>.made,
        )
    }

    # rule parameter-declaration-list { <parameter-declaration> [ <.comma> <parameter-declaration> ]* } 
    method parameter-declaration-list($/) {
        make $<parameter-declaration>>>.made
    }

    # rule parameter-declaration-body:sym<decl> { <declarator> }
    method parameter-declaration-body:sym<decl>($/) {
        make $<declarator>.made
    }

    # rule parameter-declaration-body:sym<abst> { <abstract-declarator>? }
    method parameter-declaration-body:sym<abst>($/) {
        make $<abstract-declarator>.made
    }

    # rule parameter-declaration { <attribute-specifier-seq>? <decl-specifier-seq> <parameter-declaration-body> [ <assign> <initializer-clause> ]? }
    method parameter-declaration($/) {
        make ParameterDeclaration.new(
            attribute-specifier-seq    => $<attribute-specifier-seq>.made,
            decl-specifier-seq         => $<decl-specifier-seq>.made,
            parameter-declaration-body => $<parameter-declaration-body>.made,
            initializer-clause         => $<initializer-clause>.made,
        )
    }
}

our role Parameters::Rules {

    rule parameter-declaration-clause {
        <parameter-declaration-list> [ <comma>? <ellipsis> ]?
    }

    rule parameter-declaration-list {
        <parameter-declaration> [ <comma> <parameter-declaration> ]*
    }

    #-----------------------------
    proto rule parameter-declaration-body { * }
    rule parameter-declaration-body:sym<decl> { <declarator> }
    rule parameter-declaration-body:sym<abst> { <abstract-declarator>? }

    rule parameter-declaration {
        <attribute-specifier-seq>?
        <decl-specifier-seq>
        <parameter-declaration-body>
        [ <assign> <initializer-clause> ]?
    }

    rule parameters-and-qualifiers {
        <left-paren>
        <parameter-declaration-clause>?
        <right-paren>
        <cvqualifierseq>?
        <refqualifier>?
        <exception-specification>?
        <attribute-specifier-seq>?
    }
}

use Data::Dump::Tree;

use gcpp-roles;
use gcpp-ident;
use gcpp-attr;
use gcpp-cv;

our class ParameterDeclarationClause { ... }
our class ParameterDeclaration { ... }

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
does IAbstractDeclarator
does IParameterDeclarationBody
does INoPointerDeclaratorTail {

    has ParameterDeclarationClause $.parameter-declaration-clause;
    has Cvqualifierseq             $.cvqualifierseq;
    has IRefqualifier               $.refqualifier;
    has IExceptionSpecification     $.exception-specification;
    has IAttributeSpecifierSeq      $.attribute-specifier-seq;

    has $.text;

    method gist{

        my $builder = "(";

        $builder = $builder.&maybe-extend($.parameter-declaration-clause);

        $builder ~= ") ";

        $builder = $builder.&maybe-extend($.cvqualifierseq,          padr => True);
        $builder = $builder.&maybe-extend($.refqualifier,            padr => True);
        $builder = $builder.&maybe-extend($.exception-specification, padr => True);
        $builder = $builder.&maybe-extend($.attribute-specifier-seq);

        $builder
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

        my $builder = @.parameter-declaration-list>>.gist.join(", ");

        if $.has-ellipsis {
            $builder ~= "...";
        }

        $builder
    }
}

# rule parameter-declaration-body:sym<decl> { <declarator> }
our class ParameterDeclarationBody::Decl does IParameterDeclarationBody {
    has IDeclarator $.declarator is required;

    has $.text;

    method gist{
        $.declarator.gist
    }
}

# rule parameter-declaration-body:sym<abst> { <abstract-declarator>? }
our class ParameterDeclarationBody::Abst does IParameterDeclarationBody {
    has IAbstractDeclarator $.abstract-declarator;

    has $.text;

    method gist{
        if $.abstract-declarator {
            $.abstract-declarator.gist
        } else {
            ""
        }
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

        my $builder = "";

        $builder = $builder.&maybe-extend($.attribute-specifier-seq, padr => True);

        $builder ~= $.decl-specifier-seq.gist;
        $builder = $builder.&maybe-extend($.parameter-declaration-body, padl => True);

        if $.initializer-clause {
            $builder ~= " = " ~ $.initializer-clause.gist;
        }

        $builder
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
            text                         => ~$/,
        )
    }

    # rule parameter-declaration-clause { <parameter-declaration-list> [ <.comma>? <ellipsis> ]? }
    method parameter-declaration-clause($/) {
        make ParameterDeclarationClause.new(
            parameter-declaration-list => $<parameter-declaration-list>.made,
            has-ellipsis               => $<has-ellipsis>.made,
            text                       => ~$/,
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

    # rule parameter-declaration { 
    #   <attribute-specifier-seq>? 
    #   <decl-specifier-seq> 
    #   <parameter-declaration-body> 
    #   [ <assign> <initializer-clause> ]? 
    # }
    method parameter-declaration($/) {
        make ParameterDeclaration.new(
            attribute-specifier-seq    => $<attribute-specifier-seq>.made,
            decl-specifier-seq         => $<decl-specifier-seq>.made,
            parameter-declaration-body => $<parameter-declaration-body>.made,
            initializer-clause         => $<initializer-clause>.made,
            text                       => ~$/,
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

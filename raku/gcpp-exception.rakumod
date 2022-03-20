# rule exception-declaration:sym<basic> { 
#   <attribute-specifier-seq>? 
#   <type-specifier-seq> 
#   <some-declarator>? 
# }
our class ExceptionDeclaration::Basic does IExceptionDeclaration {
    has IAttributeSpecifierSeq $.attribute-specifier-seq;
    has ITypeSpecifierSeq      $.type-specifier-seq is required;
    has ISomeDeclarator        $.some-declarator;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule exception-declaration:sym<ellipsis> { 
#   <ellipsis> 
# }
our class ExceptionDeclaration::Ellipsis does IExceptionDeclaration {

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule throw-expression { 
#   <throw> 
#   <assignment-expression>? 
# }
our class ThrowExpression does IAssignmentExpression { 
    has IAssignmentExpression $.assignment-expression;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token exception-specification:sym<dynamic> { 
#   <dynamic-exception-specification> 
# }
our class ExceptionSpecification::Dynamic does IExceptionSpecification {
    has DynamicExceptionSpecification $.dynamic-exception-specification is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token exception-specification:sym<noexcept> { 
#   <noe-except-specification> 
# }
our class ExceptionSpecification::Noexcept does IExceptionSpecification {
    has INoeExceptSpecification $.noe-except-specification is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule dynamic-exception-specification { 
#   <throw> 
#   <.left-paren> 
#   <type-id-list>? 
#   <.right-paren> 
# }
our class DynamicExceptionSpecification { 
    has TypeIdList $.type-id-list;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

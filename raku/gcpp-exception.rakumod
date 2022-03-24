use Data::Dump::Tree;

use gcpp-roles;
use gcpp-attr;
use gcpp-type-id;

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

        my $builder = "throw(";

        if $.type-id-list {
            $builder ~= $.type-id-list.gist;
        }

        $builder ~ ")"
    }
}

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

        my $builder = "";

        my $a = $.attribute-specifier-seq;

        if $a {
            $builder ~= $a.gist ~ "\n";
        }

        $builder ~= $.type-specifier-seq.gist;

        my $b = $.some-declarator;

        if $b {
            $builder ~= "\n" ~ $b.gist;
        }

        $builder
    }
}

# rule exception-declaration:sym<ellipsis> { 
#   <ellipsis> 
# }
our class ExceptionDeclaration::Ellipsis does IExceptionDeclaration {

    has $.text;

    method gist{
        "..."
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

        my $builder = "throw";

        if $.assignment-expression {
            $builder ~= " " ~ $.assignment-expression.gist;
        }

        $builder
    }
}

# token exception-specification:sym<dynamic> { 
#   <dynamic-exception-specification> 
# }
our class ExceptionSpecification::Dynamic does IExceptionSpecification {
    has DynamicExceptionSpecification $.dynamic-exception-specification is required;

    has $.text;

    method gist{
        $.dynamic-exception-specification.gist
    }
}

# token exception-specification:sym<noexcept> { 
#   <noe-except-specification> 
# }
our class ExceptionSpecification::Noexcept does IExceptionSpecification {
    has INoeExceptSpecification $.noe-except-specification is required;

    has $.text;

    method gist{
        $.noe-except-specification.gist
    }
}

our role Exception::Actions {

    # rule exception-declaration:sym<basic> { <attribute-specifier-seq>? <type-specifier-seq> <some-declarator>? }
    method exception-declaration:sym<basic>($/) {
        make ExceptionDeclaration::Basic.new(
            attribute-specifier-seq => $<attribute-specifier-seq>.made,
            type-specifier-seq      => $<type-specifier-seq>.made,
            some-declarator         => $<some-declarator>.made,
            text                    => ~$/,
        )
    }

    # rule exception-declaration:sym<ellipsis> { <ellipsis> }
    method exception-declaration:sym<ellipsis>($/) {
        make ExceptionDeclaration::Ellipsis.new
    }

    # rule throw-expression { <throw> <assignment-expression>? } 
    method throw-expression($/) {
        make ThrowExpression.new(
            assignment-expression => $<assignment-expression>.made,
            text                  => ~$/,
        )
    }

    # token exception-specification:sym<dynamic> { <dynamic-exception-specification> }
    method exception-specification:sym<dynamic>($/) {
        make $<dynamic-exception-specification>.made
    }

    # token exception-specification:sym<noexcept> { <noe-except-specification> } 
    method exception-specification:sym<noexcept>($/) {
        make $<noe-except-specification>.made
    }

    # rule dynamic-exception-specification { <throw> <.left-paren> <type-id-list>? <.right-paren> }
    method dynamic-exception-specification($/) {
        make DynamicExceptionSpecification.new(
            type-id-list => $<type-id-list>.made,
            text         => ~$/,
        )
    }
}

our role Exception::Rules {

    proto rule exception-declaration { * }

    rule exception-declaration:sym<basic> {
        <attribute-specifier-seq>?
        <type-specifier-seq>
        <some-declarator>?
    }

    rule exception-declaration:sym<ellipsis> {
        <ellipsis>
    }

    rule throw-expression {
        <throw> <assignment-expression>?
    }

    proto token exception-specification { * }
    token exception-specification:sym<dynamic>  { <dynamic-exception-specification> }
    token exception-specification:sym<noexcept> { <noe-except-specification> }

    rule dynamic-exception-specification {
        <throw> <left-paren> <type-id-list>?  <right-paren>
    }
}

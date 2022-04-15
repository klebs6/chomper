unit module Chomper::Cpp::GcppTemplate;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;
use Chomper::Cpp::GcppIdent;
use Chomper::Cpp::GcppStr;
use Chomper::Cpp::GcppParam;
use Chomper::Cpp::GcppOperatorId;
use Chomper::Cpp::GcppTypeParam;

use Chomper::TreeMark;

# rule template-parameter:sym<type> { <type-parameter> }
our class TemplateParameter::Type does ITemplateParameter {
    has TypeParameter $.type-parameter is required;
    has $.text;

    method gist(:$treemark=False) {
        $.type-parameter.gist(:$treemark)
    }
}

# rule template-parameter:sym<param> { 
#   <parameter-declaration> 
# }
our class TemplateParameter::Param does ITemplateParameter {
    has ParameterDeclaration $.parameter-declaration is required;
    has $.text;

    method gist(:$treemark=False) {
        $.parameter-declaration.gist(:$treemark)
    }
}
# rule template-argument-list { 
#   <template-argument> 
#   <ellipsis>? 
#   [ <.comma> <template-argument> <ellipsis>? ]* 
# }
our class TemplateArgumentList { 
    has ITemplateArgument @.template-arguments is required;

    has $.text;

    method gist(:$treemark=False) {
        @.template-arguments>>.gist(:$treemark).join(", ")
    }
}

# token template-argument:sym<type-id> { <the-type-id> }
our class TemplateArgument::TypeId does ITemplateArgument {
    has ITheTypeId $.the-type-id is required;

    has $.text;

    method gist(:$treemark=False) {
        $.the-type-id.gist(:$treemark)
    }
}

# token template-argument:sym<const-expr> { <constant-expression> }
our class TemplateArgument::ConstExpr does ITemplateArgument {
    has IConstantExpression $.constant-expression is required;
    has $.text;

    method gist(:$treemark=False) {
        $.constant-expression.gist(:$treemark)
    }
}

# token template-argument:sym<id-expr> { <id-expression> }
our class TemplateArgument::IdExpr does ITemplateArgument {
    has IIdExpression $.id-expression is required;
    has $.text;

    method gist(:$treemark=False) {
        $.id-expression.gist(:$treemark)
    }
}

# rule simple-template-id { 
#   <template-name> 
#   <less> 
#   <template-argument-list>? 
#   <greater> 
# }
our class SimpleTemplateId 
does IDeclSpecifierSeq 
does ITheTypeName
does ITheTypeId
does IIdExpression
does IPostListHead {

    has Identifier $.template-name is required;
    has @.template-arguments;

    has $.text;

    method gist(:$treemark=False) {

        if $treemark {
            return sigil(TreeMark::<_TemplateId>) 
        }

        $.template-name.gist(:$treemark) ~ "<"  ~ @.template-arguments>>.gist(:$treemark).join(", ") ~ ">"
    }
}

# rule template-id:sym<simple> { 
#   <simple-template-id> 
# }
our class TemplateId::Simple does ITemplateId {
    has SimpleTemplateId $.simple-template-id is required;

    has $.text;

    method gist(:$treemark=False) {
        $.simple-template-id.gist(:$treemark)
    }
}

# rule template-id:sym<operator-function-id> { 
#   <operator-function-id> 
#   <less> 
#   <template-argument-list>? 
#   <greater> 
# }
our class TemplateId::OperatorFunctionId does ITemplateId {
    has OperatorFunctionId   $.operator-function-id is required;
    has TemplateArgumentList $.template-argument-list;

    has $.text;

    method gist(:$treemark=False) {
        my $maybe-args = $.template-argument-list ?? $.template-argument-list.gist(:$treemark) !! "";
        $.operator-function-id.gist(:$treemark) ~ "<" ~ $maybe-args ~ ">"
    }
}

# rule template-id:sym<literal-operator-id> { 
#   <literal-operator-id> 
#   <less> 
#   <template-argument-list>? 
#   <greater> 
# }
our class TemplateId::LiteralOperatorId does ITemplateId {
    has ILiteralOperatorId   $.literal-operator-id is required;
    has TemplateArgumentList $.template-argument-list;

    has $.text;

    method gist(:$treemark=False) {
        my $maybe-args = $.template-argument-list ?? $.template-argument-list.gist(:$treemark) !! "";
        $.literal-operator-id.gist(:$treemark) ~ "<" ~ $maybe-args ~ ">"
    }
}

# rule template-declaration { 
#   <template> 
#   <less> 
#   <templateparameter-list> 
#   <greater> 
#   <declaration> 
# }
our class TemplateDeclaration { 
    has TemplateParameterList $.templateparameter-list is required;
    has IDeclaration          $.declaration            is required;
    has $.text;

    method gist(:$treemark=False) {
        "template<" ~ $.templateparameter-list.gist(:$treemark) ~ ">" ~ $.declaration.gist(:$treemark)
    }
}

# rule scoped-template-id { 
#   <nested-name-specifier> 
#   <.template> 
#   <simple-template-id> 
# }
our class ScopedTemplateId { 
    has INestedNameSpecifier $.nested-name-specifier is required;
    has SimpleTemplateId    $.simple-template-id is required;

    has $.text;

    method gist(:$treemark=False) {
        $.nested-name-specifier.gist(:$treemark) ~ " template " ~ $.simple-template-id.gist(:$treemark)
    }
}

our role Template::Actions {

    # rule scoped-template-id { <nested-name-specifier> <.template> <simple-template-id> }
    method scoped-template-id($/) {
        make ScopedTemplateId.new(
            nested-name-specifier => $<nested-name-specifier>.made,
            simple-template-id    => $<simple-template-id>.made,
            text                  => ~$/,
        )
    }

    # rule template-declaration { <template> <less> <templateparameter-list> <greater> <declaration> }
    method template-declaration($/) {
        make TemplateDeclaration.new(
            templateparameter-list => $<templateparameter-list>.made,
            declaration            => $<declaration>.made,
            text                   => ~$/,
        )
    }

    # rule templateparameter-list { <template-parameter> [ <.comma> <template-parameter> ]* } 
    method templateparameter-list($/) {
        make @<template-parameter>>>.made
    }

    # rule template-parameter:sym<type> { <type-parameter> }
    method template-parameter:sym<type>($/) {
        make $<type-parameter>.made
    }

    # rule template-parameter:sym<param> { <parameter-declaration> } 
    method template-parameter:sym<param>($/) {
        make $<parameter-declaration>.made
    }

    # rule simple-template-id { <template-name> <less> <template-argument-list>? <greater> } 
    method simple-template-id($/) {
        make SimpleTemplateId.new(
            template-name      => $<template-name>.made,
            template-arguments => $<template-argument-list>.made.List,
            text               => ~$/,
        )
    }

    # rule template-id:sym<simple> { <simple-template-id> }
    method template-id:sym<simple>($/) {
        make $<simple-template-id>.made
    }

    # rule template-id:sym<operator-function-id> { <operator-function-id> <less> <template-argument-list>? <greater> }
    method template-id:sym<operator-function-id>($/) {
        make TemplateId::OperatorFunctionId.new(
            operator-function-id   => $<operator-function-id>.made,
            template-argument-list => $<template-argument-list>.made,
            text                   => ~$/,
        )
    }

    # rule template-id:sym<literal-operator-id> { <literal-operator-id> <less> <template-argument-list>? <greater> } 
    method template-id:sym<literal-operator-id>($/) {
        make TemplateId::LiteralOperatorId.new(
            literal-operator-id    => $<literal-operator-id>.made,
            template-argument-list => $<template-argument-list>.made,
            text                   => ~$/,
        )
    }

    # token template-name { <identifier> }
    method template-name($/) {
        make $<identifier>.made
    }

    # rule template-argument-list { <template-argument> <ellipsis>? [ <.comma> <template-argument> <ellipsis>? ]* } 
    method template-argument-list($/) {
        make $<template-argument>>>.made
    }

    # token template-argument:sym<type-id> { <the-type-id> }
    method template-argument:sym<type-id>($/) {
        make $<the-type-id>.made
    }

    # token template-argument:sym<const-expr> { <constant-expression> }
    method template-argument:sym<const-expr>($/) {
        make $<constant-expression>.made
    }

    # token template-argument:sym<id-expr> { <id-expression> } 
    method template-argument:sym<id-expr>($/) {
        make $<id-expression>.made
    }
}

our role Template::Rules {

    rule template-argument-list {
        <template-argument> 
        <ellipsis>? 
        [ <comma> <template-argument> <ellipsis>? ]*
    }

    #---------------------
    proto token template-argument { * }
    token template-argument:sym<type-id>    { <the-type-id> }
    token template-argument:sym<const-expr> { <constant-expression> }
    token template-argument:sym<id-expr>    { <id-expression> }

    rule simple-template-id {
        <template-name>
        <less>
        <template-argument-list>?
        <greater>
    }

    #-----------------------------
    proto rule template-id { * }

    rule template-id:sym<simple> {
        <simple-template-id>
    }

    rule template-id:sym<operator-function-id> {
        <operator-function-id>
        <less>
        <template-argument-list>?
        <greater>
    }

    rule template-id:sym<literal-operator-id> {
        <literal-operator-id>
        <less>
        <template-argument-list>?
        <greater>
    }

    #-----------------------------
    token template-name {
        <identifier>
    }

    rule template-declaration {
        <template>
        <less>
        <templateparameter-list>
        <greater>
        <declaration>
    }

    rule templateparameter-list {
        <template-parameter>
        [ <comma> <template-parameter> ]*
    }

    proto rule template-parameter { * }
    rule template-parameter:sym<type>  { <type-parameter> }
    rule template-parameter:sym<param> { <parameter-declaration> }

    rule scoped-template-id {
        <nested-name-specifier> 
        <template> 
        <simple-template-id>
    }
}
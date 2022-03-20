# rule simple-template-id { 
#   <template-name> 
#   <less> 
#   <template-argument-list>? 
#   <greater> 
# }
our class SimpleTemplateId 
does IDeclSpecifierSeq 
does IPostListHead {

    has Identifier           $.template-name is required;
    has ITemplateArgument @.template-arguments;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule template-id:sym<simple> { 
#   <simple-template-id> 
# }
our class TemplateId::Simple does ITemplateId {
    has SimpleTemplateId $.simple-template-id is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
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

    method gist{
        say "need write gist!";
        ddt self;
        exit;
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

    method gist{
        say "need write gist!";
        ddt self;
        exit;
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

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token template-argument:sym<type-id> { <the-type-id> }
our class TemplateArgument::TypeId does ITemplateArgument {
    has ITheTypeId $.the-type-id is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token template-argument:sym<const-expr> { <constant-expression> }
our class TemplateArgument::ConstExpr does ITemplateArgument {
    has IConstantExpression $.constant-expression is required;
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token template-argument:sym<id-expr> { <id-expression> } #---------------------
our class TemplateArgument::IdExpr does ITemplateArgument {
    has IIdExpression $.id-expression is required;
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}


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

# token template-argument:sym<id-expr> { <id-expression> }
our class TemplateArgument::IdExpr does ITemplateArgument {
    has IIdExpression $.id-expression is required;
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

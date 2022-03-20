# rule condition:sym<expr> { 
#   <expression> 
# }
our class Condition::Expr does ICondition {
    has IExpression $.expression is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule condition-decl-tail:sym<assign-init> { 
#   <assign> 
#   <initializer-clause> 
# }
our class ConditionDeclTail::AssignInit does IConditionDeclTail {
    has IInitializerClause $.initializer-clause is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule condition-decl-tail:sym<braced-init> { 
#   <braced-init-list> 
# }
our class ConditionDeclTail::BracedInit does IConditionDeclTail {
    has BracedInitList $.braced-init-list is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule condition:sym<decl> { 
#   <attribute-specifier-seq>? 
#   <decl-specifier-seq> 
#   <declarator> 
#   <condition-decl-tail> 
# }
our class Condition::Decl does ICondition {
    has IAttributeSpecifierSeq $.attribute-specifier-seq;
    has IDeclSpecifierSeq      $.decl-specifier-seq  is required;
    has IDeclarator            $.declarator          is required;
    has IConditionDeclTail    $.condition-decl-tail is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

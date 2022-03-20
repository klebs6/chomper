
# rule new-expression:sym<new-type-id> { 
#   <doublecolon>? 
#   <new_> 
#   <new-placement>? 
#   <new-type-id> 
#   <new-initializer>? 
# }
our class NewExpression::NewTypeId does INewExpression {
    has NewPlacement   $.new-placement;
    has NewTypeId      $.new-type-id is required;
    has INewInitializer $.new-initializer;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule new-expression:sym<the-type-id> { 
#   <doublecolon>? 
#   <new_> 
#   <new-placement>? 
#   <.left-paren> 
#   <the-type-id> 
#   <.right-paren> 
#   <new-initializer>? 
# }
our class NewExpression::TheTypeId does INewExpression {
    has NewPlacement    $.new-placement;
    has ITheTypeId      $.the-type-id is required;
    has INewInitializer $.new-initializer;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule new-placement { 
#   <.left-paren> 
#   <expression-list> 
#   <.right-paren> 
# }
our class NewPlacement { 
    has ExpressionList $.expression-list is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule new-type-id { 
#   <type-specifier-seq> 
#   <new-declarator>? 
# }
our class NewTypeId { 
    has ITypeSpecifierSeq $.type-specifier-seq is required;
    has NewDeclarator    $.new-declarator     is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule new-declarator { 
#   <pointer-operator>* 
#   <no-pointer-new-declarator>? 
# }
our class NewDeclarator { 
    has IPointerOperator @.pointer-operators;
    has NoPointerNewDeclarator $.no-pointer-new-declarator;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule no-pointer-new-declarator { 
#   <.left-bracket> 
#   <expression> 
#   <.right-bracket> 
#   <attribute-specifier-seq>? 
#   <no-pointer-new-declarator-tail>* 
# }
our class NoPointerNewDeclarator { 
    has IExpression                $.expression is required;
    has IAttributeSpecifierSeq     $.attribute-specifier-seq;
    has NoPointerNewDeclaratorTail @.no-pointer-new-declarator-tail;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule no-pointer-new-declarator-tail { 
#   <.left-bracket> 
#   <constant-expression> 
#   <.right-bracket> 
#   <attribute-specifier-seq>? 
# }
our class NoPointerNewDeclaratorTail {
    has IConstantExpression    $.constant-expression is required;
    has IAttributeSpecifierSeq $.attribute-specifier-seq;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}


# rule new-initializer:sym<expr-list> { 
#   <.left-paren> 
#   <expression-list>? 
#   <.right-paren> 
# }
our class NewInitializer::ExprList does INewInitializer {
    has ExpressionList $.expression-list;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule new-initializer:sym<braced> { 
#   <braced-init-list> 
# }
our class NewInitializer::Braced does INewInitializer {
    has BracedInitList $.braced-init-list is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}


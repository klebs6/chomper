
# rule postfix-expression-cast { 
#   <cast-token> 
#   <less> 
#   <the-type-id> 
#   <greater> 
#   <.left-paren> 
#   <expression> 
#   <.right-paren> 
# }
our class PostfixExpressionCast 
does IInitializer 
does IUnaryExpression 
does IPostfixExpressionBody { 

    has ICastToken  $.cast-token  is required;
    has ITheTypeId  $.the-type-id is required;
    has IExpression $.expression  is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule postfix-expression-typeid { 
# <type-id-of-the-type-id> 
# <.left-paren> 
# [ <expression> || <the-type-id>] 
# <.right-paren> 
# } 
our class PostfixExpressionTypeid::Expr { 
    has TypeIdOfTheTypeId $.type-id-of-the-type-id is required;
    has IExpression       $.expression             is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class PostfixExpressionTypeid::TypeId { 
    has TypeIdOfTheTypeId $.type-id-of-the-type-id is required;
    has ITheTypeId        $.the-type-id            is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token post-list-head:sym<simple> { <simple-type-specifier> }
our class PostListHead::Simple does IPostListHead {
    has ISimpleTypeSpecifier $.simple-type-specifier is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token post-list-head:sym<type-name> { <type-name-specifier> } 
our class PostListHead::TypeName does IPostListHead {
    has ITypeNameSpecifier $.type-name-specifier is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

=begin comment
# token post-list-tail:sym<parenthesized> { <.left-paren> <expression-list>? <.right-paren> }
our class PostListTail::Parenthesized does IPostListTail {
    has ExpressionList $.expression-list;
}

# token post-list-tail:sym<braced> { <braced-init-list> }
our class PostListTail::Braced does IPostListTail {
    has BracedInitList $.braced-init-list is required;
}
=end comment

our class PostListTail does IPostListTail {
    has $.value is required;
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token postfix-expression-list { 
#   <post-list-head> 
#   <post-list-tail> 
# }
our class PostfixExpressionList 
does IInitializer 
does IUnaryExpression 
does IPostfixExpressionBody { 

    has IPostListHead $.post-list-head is required;
    has IPostListTail $.post-list-tail is required;
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule postfix-expression { 
#   <postfix-expression-body> 
#   <postfix-expression-tail>* 
# }
our class PostfixExpression 
does IStatement 
does IReturnStatementBody 
does IUnaryExpression { 
    has IPostfixExpressionBody $.postfix-expression-body is required;
    has IPostfixExpressionTail @.postfix-expression-tail;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class PostfixExpressionTail::Null 
does IPostfixExpressionTail {

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

#------------------------------

# rule bracket-tail { 
#   <.left-bracket>
#   [ <expression> || <braced-init-list> ]
#   <.right-bracket>
# }
our class BracketTail::Expression 
does IPostfixExpressionTail { 

    has IExpression $.expression is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class BracketTail::BracedInitList 
does IPostfixExpressionTail {

    has IBracketTail $.bracket-tail is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule postfix-expression-tail:sym<bracket> { 
#   <bracket-tail> 
# }
our class PostfixExpressionTail::Bracket 
does IPostfixExpressionTail {

    has IBracketTail $.bracket-tail is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule postfix-expression-tail:sym<parens> { 
#   <.left-paren> 
#   <expression-list>? 
#   <.right-paren> 
# }
our class PostfixExpressionTail::Parens 
does IPostfixExpressionTail {

    has ExpressionList $.expression-list;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule postfix-expression-tail:sym<indirection-id> { 
#   [ <dot> || <arrow> ] 
#   <template>? 
#   <id-expression> 
# }
our class PostfixExpressionTail::IndirectionId 
does IPostfixExpressionTail {

    has Bool         $.template is required;
    has IIdExpression $.id-expression is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule postfix-expression-tail:sym<indirection-pseudo-dtor> { 
#   [ <dot> || <arrow> ] 
#   <pseudo-destructor-name> 
# }
our class PostfixExpressionTail::IndirectionPseudoDtor 
does IPostfixExpressionTail {

    has IPseudoDestructorName $.pseudo-destructor-name is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule postfix-expression-tail:sym<pp-mm> { 
#   [ <plus-plus> || <minus-minus> ] 
# } 
our class PostfixExpressionTail::PlusPlus 
does IPostfixExpressionTail { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class PostfixExpressionTail::MinusMinus 
does IPostfixExpressionTail { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

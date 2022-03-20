
# rule initializer:sym<brace-or-eq> { 
#   <brace-or-equal-initializer> 
# }
our class Initializer::BraceOrEq does IInitializer {
    has IBraceOrEqualInitializer $.brace-or-equal-initializer is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Initializer does IInitializer {
    has $.value is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule initializer:sym<paren-expr-list> { 
#   <.left-paren> 
#   <expression-list> 
#   <.right-paren> 
# }
our class Initializer::ParenExprList does IInitializer {
    has ExpressionList $.expression-list is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule brace-or-equal-initializer:sym<assign-init> { 
#   <assign> 
#   <initializer-clause> 
# }
our class BraceOrEqualInitializer::AssignInit does IBraceOrEqualInitializer {
    has IInitializerClause $.initializer-clause is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule brace-or-equal-initializer:sym<braced-init-list> { 
#   <braced-init-list> 
# }
our class BraceOrEqualInitializer::BracedInitList 
does IBraceOrEqualInitializer {

    has BracedInitList $.braced-init-list is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule initializer-clause:sym<assignment> { 
#   <comment>? 
#   <assignment-expression> 
# }
our class InitializerClause::Assignment 
does IInitializerClause {

    has IComment              $.comment;
    has IAssignmentExpression $.assignment-expression is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule initializer-clause:sym<braced> { 
#   <comment>? 
#   <braced-init-list> 
# }
our class InitializerClause::Braced 
does IInitializerClause {

    has IComment       $.comment;
    has BracedInitList $.braced-init-list is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule initializer-list { 
#   <initializer-clause> 
#   <ellipsis>? 
#   [ <.comma> <initializer-clause> <ellipsis>? ]* 
# }
our class InitializerList 
does IInitializerClause 
does IPostfixExpressionTail {

    has IInitializerClause @.clauses is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule braced-init-list { 
#   <.left-brace> 
#   [ <initializer-list> <.comma>? ]? 
#   <.right-brace> 
# } #-----------------------------
our class BracedInitList 
does IReturnStatementBody 
does IInitializerClause {

    has InitializerList $.initializer-list;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

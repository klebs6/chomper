# rule for-init-statement:sym<expression-statement> { 
#   <expression-statement> 
# }
our class ForInitStatement::ExpressionStatement 
does IForInitStatement {

    has ExpressionStatement $.expression-statement is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule for-init-statement:sym<simple-declaration> { 
#   <simple-declaration> 
# }
our class ForInitStatement::SimpleDeclaration does IForInitStatement {
    has ISimpleDeclaration $.simple-declaration is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}



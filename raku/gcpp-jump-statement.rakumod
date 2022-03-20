
# rule jump-statement:sym<break> { 
#   <break_> 
#   <semi> 
# }
our class JumpStatement::Break does IJumpStatement { 
    has IComment $.comment;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule jump-statement:sym<continue> { 
#   <continue_> 
#   <semi> 
# }
our class JumpStatement::Continue does IJumpStatement {
    has IComment $.comment;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule jump-statement:sym<return> { 
#   <return_> 
#   <return-statement-body>? 
#   <semi> 
# }
our class JumpStatement::Return 
does IAttributedStatementBody 
does IJumpStatement {

    has IComment             $.comment;
    has IReturnStatementBody $.return-statement-body;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule jump-statement:sym<goto> { 
#   <goto_> 
#   <identifier> 
#   <semi> 
# }
our class JumpStatement::Goto does IJumpStatement {
    has IComment   $.comment;
    has Identifier $.identifier is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

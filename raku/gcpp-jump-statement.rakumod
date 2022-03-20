
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

our role JumpStatement::Actions {

    # rule jump-statement:sym<break> { <break_> <semi> }
    method jump-statement:sym<break>($/) {
        make JumpStatement::Break.new(
            comment => $<semi>.made,
        )
    }

    # rule jump-statement:sym<continue> { <continue_> <semi> }
    method jump-statement:sym<continue>($/) {
        make JumpStatement::Continue.new(
            comment => $<semi>.made,
        )
    }

    # rule jump-statement:sym<return> { <return_> <return-statement-body>? <semi> }
    method jump-statement:sym<return>($/) {
        make JumpStatement::Return.new(
            comment               => $<semi>.made,
            return-statement-body => $<return-statement-body>.made,
        )
    }

    # rule jump-statement:sym<goto> { <goto_> <identifier> <semi> }
    method jump-statement:sym<goto>($/) {
        make JumpStatement::Goto.new(
            comment    => $<semi>.made,
            identifier => $<identifier>.made,
        )
    }
}

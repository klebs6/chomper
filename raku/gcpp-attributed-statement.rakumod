
# rule attributed-statement-body:sym<expression> { 
#   <expression-statement> 
# }
our class AttributedStatementBody::Expression 
does IAttributedStatementBody {

    has ExpressionStatement $.expression-statement is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule attributed-statement-body:sym<compound> { 
#   <compound-statement> 
# }
our class AttributedStatementBody::Compound 
does IAttributedStatementBody {

    has CompoundStatement $.compound-statement is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule attributed-statement-body:sym<selection> { 
#   <selection-statement> 
# }
our class AttributedStatementBody::Selection 
does IAttributedStatementBody {

    has ISelectionStatement $.selection-statement is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule attributed-statement-body:sym<iteration> { 
#   <iteration-statement> 
# }
our class AttributedStatementBody::Iteration 
does IAttributedStatementBody {

    has IIterationStatement $.iteration-statement is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule attributed-statement-body:sym<jump> { 
#   <jump-statement> 
# }
our class AttributedStatementBody::Jump 
does IAttributedStatementBody {

    has IJumpStatement $.jump-statement is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule attributed-statement-body:sym<try> { 
#   <try-block> 
# }
our class AttributedStatementBody::Try 
does IAttributedStatementBody {

    has TryBlock $.try-block is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

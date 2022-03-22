use Data::Dump::Tree;

use gcpp-roles;
use gcpp-statement;
use gcpp-try;
use gcpp-attr;

# token statement:sym<attributed> { 
#   <comment>? 
#   <attribute-specifier-seq>? 
#   <attributed-statement-body> 
# }
our class Statement::Attributed does IStatement {
    has IComment  $.comment is rw;
    has           @.attribute-specifier-seq is rw;
    has           $.attributed-statement-body is required is rw;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule attributed-statement-body:sym<expression> { 
#   <expression-statement> 
# }
our class AttributedStatementBody::Expression 
does IAttributedStatementBody {

    has ExpressionStatement $.expression-statement is required;

    has $.text;

    method gist{
        $.expression-statement.gist
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
        $.compound-statement.gist
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
        $.selection-statement.gist
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
        $.iteration-statement.gist
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
        $.jump-statement.gist
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
        $.try-block.gist
    }
}

our role AttributedStatement::Actions {

    # token statement:sym<attributed> { <comment>? <attribute-specifier-seq>? <attributed-statement-body> }
    method statement:sym<attributed>($/) {

        my $comment = $<comment>.made;
        my $attribs = $<attribute-specifier-seq>.made;
        my $body    = $<attributed-statement-body>.made;

        if not $comment and not $attribs {

            make $body

        } else {

            my $res = Statement::Attributed.new(
                attributed-statement-body => $body,
            );

            if $comment {
                $res.comment = $comment;
            }

            if $attribs {
                $res.attribute-specifier-seq = $attribs;
            }

            make $res
        }
    }

    # rule attributed-statement-body:sym<expression> { <expression-statement> }
    method attributed-statement-body:sym<expression>($/) {
        make $<expression-statement>.made;
    }

    # rule attributed-statement-body:sym<compound> { <compound-statement> }
    method attributed-statement-body:sym<compound>($/) {
        make $<compound-statement>.made;
    }

    # rule attributed-statement-body:sym<selection> { <selection-statement> }
    method attributed-statement-body:sym<selection>($/) {
        make $<selection-statement>.made
    }

    # rule attributed-statement-body:sym<iteration> { <iteration-statement> }
    method attributed-statement-body:sym<iteration>($/) {
        make $<iteration-statement>.made
    }

    # rule attributed-statement-body:sym<jump> { <jump-statement> }
    method attributed-statement-body:sym<jump>($/) {
        make $<jump-statement>.made
    }

    # rule attributed-statement-body:sym<try> { <try-block> } 
    method attributed-statement-body:sym<try>($/) {
        make $<try-block>.made
    }
}

our role AttributedStatement::Rules {

    token statement:sym<attributed> { 
        <comment>?
        <attribute-specifier-seq>?
        <attributed-statement-body>
    }

    proto rule attributed-statement-body { * }
    rule attributed-statement-body:sym<expression> { <expression-statement> }
    rule attributed-statement-body:sym<compound>   { <compound-statement>   }
    rule attributed-statement-body:sym<selection>  { <selection-statement>  }
    rule attributed-statement-body:sym<iteration>  { <iteration-statement>  }
    rule attributed-statement-body:sym<jump>       { <jump-statement>       }
    rule attributed-statement-body:sym<try>        { <try-block>            }
}

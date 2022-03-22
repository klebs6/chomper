use Data::Dump::Tree;

use gcpp-roles;
use gcpp-attr;
use gcpp-labeled-statement;

# regex statement-seq { 
#   <statement> 
#   [<.ws> <statement>]* 
# }
our class StatementSeq {
    has IStatement @.statements is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule compound-statement { 
#   <.left-brace> 
#   <statement-seq>? 
#   <.right-brace> 
# }
our class CompoundStatement does IStatement {
    has $.statement-seq;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token statement:sym<labeled> { 
#   <comment>? 
#   <labeled-statement> 
# }
our class Statement::Labeled does IStatement {
    has IComment         $.comment;
    has LabeledStatement $.labeled-statement is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token statement:sym<declaration> { 
#   <comment>? 
#   <declaration-statement> 
# }
our class Statement::Declaration does IStatement {
    has IComment              $.comment;
    has IDeclarationStatement $.declaration-statement is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule declaration-statement { 
#   <block-declaration> 
# }
our class DeclarationStatement does IDeclarationStatement {
    has IBlockDeclaration $.block-declaration is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule expression-statement { 
#   <expression>? 
#   <semi> 
# }
our class ExpressionStatement does IStatement { 
    has IComment    $.comment;
    has IExpression $.expression;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}



our role Statement::Actions {

    # rule declaration-statement { <block-declaration> } 
    method declaration-statement($/) {
        make $<block-declaration>.made
    }

    # rule expression-statement { <expression>? <semi> }
    method expression-statement($/) {

        my $comment = $<semi>.made;
        my $body    = $<expression>.made;

        if $comment {
            make ExpressionStatement.new(
                comment    => $comment,
                expression => $body,
            )
        } else {
            make $body
        }
    }

    # rule compound-statement { <.left-brace> <statement-seq>? <.right-brace> }
    method compound-statement($/) {
        make CompoundStatement.new(
            statement-seq => $<statement-seq>.made
        )
    }

    # regex statement-seq { <statement> [<.ws> <statement>]* } 
    method statement-seq($/) {
        make $<statement>>>.made;
    }

    # token statement:sym<declaration> { <comment>? <declaration-statement> }
    method statement:sym<declaration>($/) {

        my $comment = $<comment>.made;
        my $body    = $<declaration-statement>.made;

        if not $comment {

            make $body

        } else {

            make Statement::Declaration.new(
                comment               => $comment,
                declaration-statement => $body,
            )
        }
    }
}

our role Statement::Rules {

    proto token statement { * }

    token statement:sym<labeled>     { <comment>? <labeled-statement>     }
    token statement:sym<declaration> { <comment>? <declaration-statement> }

    rule compound-statement {
        <left-brace> <statement-seq>?  <right-brace>
    }

    regex statement-seq {
        <statement> [<ws> <statement>]*
    }
}

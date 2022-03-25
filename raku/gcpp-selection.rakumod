use Data::Dump::Tree;

use gcpp-roles;

# rule selection-statement:sym<if> { 
#   <.if_> 
#   <.left-paren> 
#   <condition> 
#   <.right-paren> 
#   <statement> 
#   [ <comment>? <else_> <statement> ]? 
# }
our class SelectionStatement::If 
does IAttributedStatementBody 
does ISelectionStatement {
    has ICondition  $.condition is required;
    has IStatement  @.statements is required;
    has IComment    $.else-statement-comment;
    has IStatement  @.else-statements;

    has $.text;

    method gist{

        my $builder = "if (" ~ $.condition.gist ~ ") ";

        for @.statements {
            $builder ~= $_.gist.indent(4) ~ "\n";
        }

        if $.else-statement-comment {
            $builder ~= "\n" ~ $.else-statement-comment.gist;
        }

        for @.else-statements {
            $builder ~= "else " ~ $_.gist ~ "\n";
        }

        $builder
    }
}

# rule selection-statement:sym<switch> { 
#   <switch> 
#   <.left-paren> 
#   <condition> 
#   <.right-paren> 
#   <statement> 
# } #-----------------------------
our class SelectionStatement::Switch does ISelectionStatement {
    has ICondition  $.condition is required;
    has IStatement $.statement is required;

    has $.text;

    method gist{
        "switch (" ~ $.condition.gist ~ ") " ~ $.statement.gist
    }
}

our role SelectionStatement::Actions {

    # rule selection-statement:sym<if> { 
    #   <if_> 
    #   <.left-paren> 
    #   <condition> 
    #   <.right-paren> 
    #   <statement> 
    #   [ <comment>? <else_> <statement> ]? 
    # }
    method selection-statement:sym<if>($/) {

        my @statements = $<statement>>>.made;

        if @statements[1] {
            make SelectionStatement::If.new(
                condition              => $<condition>.made,
                statements             => @statements[0].List,
                else-statement-comment => $<comment>.made // Nil,
                else-statements        => @statements[1].List,
                text                   => ~$/,
            )
        } else {
            make SelectionStatement::If.new(
                condition              => $<condition>.made,
                statements             => @statements[0].List,
                text                   => ~$/,
            )
        }
    }

    # rule selection-statement:sym<switch> { 
    #   <switch> 
    #   <.left-paren> 
    #   <condition> 
    #   <.right-paren> 
    #   <statement> 
    # }
    method selection-statement:sym<switch>($/) {
        make SelectionStatement::Switch.new(
            condition => $<condition>.made,
            statement => $<statement>.made,
            text      => ~$/,
        )
    }
}

our role SelectionStatement::Rules {

    proto rule selection-statement { * }

    rule selection-statement:sym<if> {  
        <if_>
        <left-paren>
        <condition>
        <right-paren>
        <statement>
        [ <comment>? <else_> <statement> ]?
    }

    rule selection-statement:sym<switch> {  
        <switch> 
        <left-paren> 
        <condition> 
        <right-paren> 
        <statement>
    }
}

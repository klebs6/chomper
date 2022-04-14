use Data::Dump::Tree;

use gcpp-roles;

use tree-mark;

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

    method gist(:$treemark=False) {

        my $builder = "if (";

        if $treemark {
            $builder ~= sigil(TreeMark::<_Condition>);

        } else {
            $builder ~= $.condition.gist(:$treemark);
        }

        $builder ~= ") ";

        if $treemark {

            $builder ~= sigil(TreeMark::<_Statements>);

        } else {
            for @.statements {
                $builder ~= $_.gist(:$treemark).indent(4) ~ "\n";
            }
        }

        if $.else-statement-comment and not $treemark {
            $builder ~= "\n" ~ $.else-statement-comment.gist(:$treemark);
        }

        for @.else-statements {
            if $treemark {
                $builder ~= " else " ~ sigil(TreeMark::<_Statements>) ~ "\n";

            } else {
                $builder ~= "else " ~ $_.gist(:$treemark) ~ "\n";
            }
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

    method gist(:$treemark=False) {
        "switch (" ~ $.condition.gist(:$treemark) ~ ") " ~ $.statement.gist(:$treemark)
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

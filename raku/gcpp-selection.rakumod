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
        say "need write gist!";
        ddt self;
        exit;
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
        say "need write gist!";
        ddt self;
        exit;
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
            )
        } else {
            make SelectionStatement::If.new(
                condition              => $<condition>.made,
                statements             => @statements[0].List,
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

use Data::Dump::Tree;

use gcpp-roles;
use gcpp-for-range;

# rule iteration-statement:sym<while> { 
#   <while_> 
#   <.left-paren> 
#   <condition> 
#   <.right-paren> <statement> 
# }
our class IterationStatement::While 
does IIterationStatement {

    has ICondition $.condition is required;
    has IStatement @.statements is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule iteration-statement:sym<do> { 
#   <.do_> 
#   <statement> 
#   <.while_> 
#   <.left-paren> 
#   <expression> 
#   <.right-paren> 
#   <.semi> 
# }
our class IterationStatement::Do does IIterationStatement {
    has IComment    $.comment;
    has IStatement  $.statement is required;
    has IExpression $.expression is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule iteration-statement:sym<for> { 
#   <.for_> 
#   <.left-paren> 
#   <for-init-statement> 
#   <condition>? 
#   <semi> 
#   <expression>? 
#   <.right-paren> 
#   <statement> 
# }
our class IterationStatement::For does IIterationStatement {
    has IForInitStatement $.for-init-statement is required;
    has ICondition        $.condition;
    has IExpression       $.expression;
    has IStatement        @.statements is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule iteration-statement:sym<for-range> { 
#   <.for_> 
#   <.left-paren> 
#   <for-range-declaration> 
#   <.colon> 
#   <for-range-initializer> 
#   <.right-paren> 
#   <statement> 
# } #-----------------------------
our class IterationStatement::ForRange does IIterationStatement {
    has ForRangeDeclaration  $.for-range-declaration is required;
    has IForRangeInitializer $.for-range-initializer is required;
    has IStatement           @.statements is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our role IterationStatement::Actions {

    # rule iteration-statement:sym<while> { <while_> <.left-paren> <condition> <.right-paren> <statement> }
    method iteration-statement:sym<while>($/) {
        make IterationStatement::While.new(
            condition  => $<condition>.made,
            statements => $<statement>.made.List,
        )
    }

    # rule iteration-statement:sym<do> { <do_> <statement> <while_> <.left-paren> <expression> <.right-paren> <semi> }
    method iteration-statement:sym<do>($/) {
        make IterationStatement::Do.new(
            comment    => $<semi>.made // Nil,
            statement  => $<statement>.made,
            expression => $<expression>.made,
        )
    }

    # rule iteration-statement:sym<for> { 
    #   <for_> 
    #   <.left-paren> 
    #   <for-init-statement> 
    #   <condition>? 
    #   <semi> 
    #   <expression>? 
    #   <.right-paren> 
    #   <statement> 
    # }
    method iteration-statement:sym<for>($/) {
        make IterationStatement::For.new(
            comment            => $<semi>.made,
            for-init-statement => $<for-init-statement>.made,
            condition          => $<condition>.made,
            expression         => $<expression>.made,
            statements         => $<statement>.made.List,
        )
    }

    # rule iteration-statement:sym<for-range> { 
    #   <.for_> 
    #   <.left-paren> 
    #   <for-range-declaration> 
    #   <.colon> 
    #   <for-range-initializer> 
    #   <.right-paren> 
    #   <statement> 
    # } 
    method iteration-statement:sym<for-range>($/) {
        make IterationStatement::ForRange.new(
            for-range-declaration => $<for-range-declaration>.made,
            for-range-initializer => $<for-range-initializer>.made,
            statements            => $<statement>.made.List,
        )
    }
}

our role IterationStatement::Rules {

    proto rule iteration-statement { * }

    rule iteration-statement:sym<while> {
        <while_>
        <left-paren>
        <condition>
        <right-paren>
        <statement>
    }

    rule iteration-statement:sym<do> {
        <do_>
        <statement>
        <while_>
        <left-paren>
        <expression>
        <right-paren>
        <semi>
    }

    rule iteration-statement:sym<for> {
        <for_>
        <left-paren>
        <for-init-statement>
        <condition>?
        <semi>
        <expression>?
        <right-paren>
        <statement>
    }

    rule iteration-statement:sym<for-range> {
        <for_>
        <left-paren>
        <for-range-declaration>
        <colon>
        <for-range-initializer>
        <right-paren>
        <statement>
    }
}
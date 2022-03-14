our class Statements {
    has @.statements;
    has $.maybe-expression-noblock;

    has $.text;

    submethod TWEAK {
        say self.gist;
    }

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class LetStatement {
    has $.maybe-comment;
    has @.outer-attributes;
    has $.pattern-no-top-alt;
    has $.maybe-type;
    has $.maybe-expression;
    has $.maybe-line-comment;

    has $.text;

    submethod TWEAK {
        say self.gist;
    }

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ExpressionStatementNoBlock {
    has $.maybe-comment;
    has $.expression-noblock;

    has $.text;

    submethod TWEAK {
        say self.gist;
    }

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ExpressionStatementBlock {
    has $.maybe-comment;
    has $.expression-with-block;

    has $.text;

    submethod TWEAK {
        say self.gist;
    }

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our role Statement::Rules {

    rule statements {  
        <statement>*
        <expression-noblock>?
    }

    proto rule statement { * }

    rule statement:sym<semi>  { <tok-semi> }
    rule statement:sym<let>   { <let-statement> }
    rule statement:sym<expr>  { <expression-statement> }
    rule statement:sym<macro> { <macro-invocation> }
    rule statement:sym<item>  { <crate-item> }

    regex let-statement {
        <comment>?
        <outer-attribute>*
        <kw-let>
        <pattern-no-top-alt>
        [
            <tok-colon>
            <type>
        ]?
        [
            <tok-eq>
            <expression>
        ]?
        <tok-semi>
        <line-comment>? 
    }

    proto rule expression-statement { * }

    rule expression-statement:sym<noblock> { <comment>? <expression-noblock> <tok-semi> }
    rule expression-statement:sym<block>   { <comment>? <expression-with-block> <tok-semi>? }
}

our role Statement::Actions {

    method statements($/) {  
        <statement>*
        <expression-noblock>?
    }

    method statement:sym<semi>($/)  { <tok-semi> }
    method statement:sym<let>($/)   { <let-statement> }
    method statement:sym<expr>($/)  { <expression-statement> }
    method statement:sym<macro>($/) { <macro-invocation> }
    method statement:sym<item>($/)  { <crate-item> }

    method let-statement($/) {
        <comment>?
        <outer-attribute>*
        <kw-let>
        <pattern-no-top-alt>
        [
            <tok-colon>
            <type>
        ]?
        [
            <tok-eq>
            <expression>
        ]?
        <tok-semi>
        <line-comment>? 
    }

    method expression-statement:sym<noblock>($/) { <comment>? <expression-noblock> <tok-semi> }
    method expression-statement:sym<block>($/)   { <comment>? <expression-with-block> <tok-semi>? }
}

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
        make Statements.new(
            statements               => $<statement>>>.made,
            maybe-expression-noblock => $<expression-noblock>.made,
            text       => $/.Str,
        )
    }

    method statement:sym<let>($/)   { make $<let-statement>.made }
    method statement:sym<expr>($/)  { make $<expression-statement>.made }
    method statement:sym<macro>($/) { make $<macro-invocation>.made }
    method statement:sym<item>($/)  { make $<crate-item>.made }

    method let-statement($/) {
        make LetStatement.new(
            maybe-comment      => $<comment>.made,
            outer-attributes   => $<outer-attribute>>>.made,
            pattern-no-top-alt => $<pattern-no-top-alt>.made,
            maybe-type         => $<type>.made,
            maybe-expression   => $<expression>.made,
            maybe-line-comment => $<line-comment>.made,
            text       => $/.Str,
        )
    }

    method expression-statement:sym<noblock>($/) { 
        make ExpressionStatementNoBlock.new(
            maybe-comment      => $<comment>.made,
            expression-noblock => $<expression-noblock>.made,
            text       => $/.Str,
        )
    }

    method expression-statement:sym<block>($/) { 
        make ExpressionStatementBlock.new(
            maybe-comment         => $<comment>.made,
            expression-with-block => $<expression-with-block>.made,
            text       => $/.Str,
        )
    }
}

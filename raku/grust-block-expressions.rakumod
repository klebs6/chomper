our class BlockExpression {
    has @.inner-attributes;
    has $.statements;

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

our class AsyncBlockExpression {
    has Bool $.move;
    has $.block-expression;

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

our class UnsafeBlockExpression {
    has $.block-expression;

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

our role BlockExpression::Rules {

    rule block-expression {
        <tok-lbrace>
        <inner-attribute>*
        <statements>?
        <tok-rbrace>
    }

    rule async-block-expression {
        <kw-async>
        <kw-move>?
        <block-expression>
    }

    rule unsafe-block-expression {
        <kw-unsafe>
        <block-expression>
    }
}

our role BlockExpression::Actions {

    method block-expression($/) {
        make BlockExpression.new(
            inner-attributes => $<inner-attributes>>>.made,
            statements       => $<statements>.made,
        )
    }

    method async-block-expression($/) {
        make AsyncBlockExpression.new(
            move             => so $/<kw-move>:exists,
            block-expression => $<block-expression>.made,
        )
    }

    method unsafe-block-expression($/) {
        make UnsafeBlockExpression.new(
            block-expression => $<block-expression>.made,
        )
    }
}

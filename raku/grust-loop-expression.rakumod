our class LoopExpressionInfinite {
    has $.maybe-loop-label;
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

our class LoopExpressionPredicate {
    has $.maybe-loop-label;
    has $.expression-nostruct;
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

our class LoopExpressionPredicatePattern {
    has $.maybe-loop-label;
    has $.pattern;
    has $.scrutinee;
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

our class LoopExpressionIterator {
    has $.maybe-loop-label;
    has $.pattern;
    has $.expression-nostruct;
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

our class LoopLabel {
    has $.lifetime-or-label;

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

our role LoopExpression::Rules {

    proto rule loop-expression { * }

    rule loop-expression:sym<infinite-loop> {
        <loop-label>?
        <kw-loop> <block-expression>
    }

    rule loop-expression:sym<predicate-loop> {
        <loop-label>?
        <kw-while> <expression-nostruct> <block-expression>
    }

    rule loop-expression:sym<predicate-pattern-loop> {
        <loop-label>?
        <kw-while>
        <kw-let>
        <pattern>
        <tok-eq>
        <scrutinee-except-lazy-boolean-operator-expression>
        <block-expression>
    }

    rule loop-expression:sym<iterator-loop> {
        <loop-label>?
        <kw-for>
        <pattern>
        <kw-in>
        <expression-nostruct>
        <block-expression>
    }

    rule loop-label {
        <lifetime-or-label> 
        <tok-colon>
    }
}

our role LoopExpression::Actions {

    method loop-expression:sym<infinite-loop>($/) {
        <loop-label>?
        <kw-loop> <block-expression>
    }

    method loop-expression:sym<predicate-loop>($/) {
        <loop-label>?
        <kw-while> <expression-nostruct> <block-expression>
    }

    method loop-expression:sym<predicate-pattern-loop>($/) {
        <loop-label>?
        <kw-while>
        <kw-let>
        <pattern>
        <tok-eq>
        <scrutinee-except-lazy-boolean-operator-expression>
        <block-expression>
    }

    method loop-expression:sym<iterator-loop>($/) {
        <loop-label>?
        <kw-for>
        <pattern>
        <kw-in>
        <expression-nostruct>
        <block-expression>
    }

    method loop-label($/) {
        <lifetime-or-label> 
        <tok-colon>
    }
}

use Data::Dump::Tree;

our class LoopExpressionInfinite {
    has $.maybe-loop-label;
    has $.block-expression;

    has $.text;

    method gist {

        my $builder = "";

        if $.maybe-loop-label {
            $builder ~= $.maybe-loop-label.gist ~ " ";
        }

        $builder ~= "loop " ~ $.block-expression.gist;

        $builder
    }
}

our class LoopExpressionPredicate {
    has $.maybe-loop-label;
    has $.expression-nostruct;
    has $.block-expression;

    has $.text;

    method gist {

        my $builder = "";

        if $.maybe-loop-label {
            $builder ~= $.maybe-loop-label.gist ~ " ";
        }

        $builder ~= "while " ~ $.expression-nostruct.gist;
        $builder ~= $.block-expression.gist;
        $builder
    }
}

our class LoopExpressionPredicatePattern {
    has $.maybe-loop-label;
    has $.pattern;
    has $.scrutinee;
    has $.block-expression;

    has $.text;

    method gist {

        my $builder = "";

        if $.maybe-loop-label {
            $builder ~= $.maybe-loop-label.gist ~ " ";
        }

        $builder ~= "whlie let " ~ $.pattern.gist;

        $builder ~= " = " ~ $.scrutinee.gist;

        $builder ~= $.block-expression.gist;

        $builder
    }
}

our class LoopExpressionIterator {
    has $.maybe-loop-label;
    has $.pattern;
    has $.expression-nostruct;
    has $.block-expression;

    has $.text;

    method gist {

        my $builder = "";

        if $.maybe-loop-label {
            $builder ~= $.maybe-loop-label.gist ~ " ";
        }

        $builder ~= "for " ~ $.pattern.gist ~ " ";
        $builder ~= "in "  ~ $.expression-nostruct.gist ~ " ";
        $builder ~= $.block-expression.gist;

        $builder
    }
}

our class LoopLabel {
    has $.lifetime-or-label;

    has $.text;

    method gist {
        $.lifetime-or-label.gist ~ ":"
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
        make LoopExpressionInfinite.new(
            loop-label       => $<loop-label>.made,
            block-expression => $<block-expression>.made,
            text             => $/.Str,
        )
    }

    method loop-expression:sym<predicate-loop>($/) {
        make LoopExpressionPredicate.new(
            maybe-loop-label    => $<loop-label>.made,
            expression-nostruct => $<expression-nostruct>.made,
            block-expression    => $<block-expression>.made,
            text                => $/.Str,
        )
    }

    method loop-expression:sym<predicate-pattern-loop>($/) {
        make LoopExpressionPredicatePattern.new(
            maybe-loop-label => $<loop-label>.made,
            pattern          => $<pattern>.made,
            scrutinee        => $<scrutinee-except-lazy-boolean-operator-expression>.made,
            block-expression => $<block-expression>.made,
            text             => $/.Str,
        )
    }

    method loop-expression:sym<iterator-loop>($/) {
        make LoopExpressionIterator.new(
            maybe-loop-label    => $<loop-label>.made,
            pattern             => $<pattern>.made,
            expression-nostruct => $<expression-nostruct>.made,
            block-expression    => $<block-expression>.made,
            text                => $/.Str,
        )
    }

    method loop-label($/) {
        make LoopLabel.new(
            lifetime-or-label => $<lifetime-or-label>.made,
            text              => $/.Str,
        )
    }
}

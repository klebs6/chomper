use Data::Dump::Tree;

our class ContinueExpression {
    has $.maybe-lifetime-or-label;

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

our class BreakExpression {
    has $.maybe-lifetime-or-label;
    has $.maybe-expression;

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

our class ReturnExpression {
    has $.maybe-expression;

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

our role JumpExpression::Rules {

    rule continue-expression {
        <kw-continue>
        <lifetime-or-label>?
    }

    rule break-expression {
        <kw-break> 
        <lifetime-or-label>?
        <expression>?
    }

    rule return-expression {
        <kw-return> <expression>? 
    }
}

our role JumpExpression::Actions {

    method continue-expression($/) {
        make ContinueExpression.new(
            maybe-lifetime-or-label => $<lifetime-or-label>.made,
            text                    => $/.Str,
        )
    }

    method break-expression($/) {
        make BreakExpression.new(
            maybe-lifetime-or-label => $<lifetime-or-label>.made,
            maybe-expression        => $<expression>.made,
            text                    => $/.Str,
        )
    }

    method return-expression($/) {
        make ReturnExpression.new(
            maybe-expression => $<expression>.made,
            text             => $/.Str,
        )
    }
}

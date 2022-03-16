use Data::Dump::Tree;

our class TupleExpression {
    has $.maybe-tuple-elements;

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

our class TupleElements {
    has @.expressions;

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

our class TupleIndex {
    has Int $.value;

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

our role TupleExpression::Rules {

    rule tuple-elements {
        <expression>* %% <tok-comma>
    }

    rule tuple-expression {
        <tok-lparen> <tuple-elements>? <tok-rparen> 
    }

    token tuple-index { <integer-literal> }
}

our role TupleExpression::Actions {
    method tuple-elements($/) {
        make TupleElements.new(
            expression => $<expression>>>.made,
            text       => $/.Str,
        )
    }

    method tuple-expression($/) {
        make TupleExpression.new(
            maybe-tuple-elements => $<tuple-elements>.made,
            text                 => $/.Str,
        )
    }

    method tuple-index($/) { 
        make $<integer-literal>.made 
    }
}

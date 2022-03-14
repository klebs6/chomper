our class TupleStructPattern {
    has $.path-in-expression;
    has $.maybe-tuple-struct-items;

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

our class TupleStructItems {
    has @.patterns;

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

our class TuplePattern {
    has $.maybe-tuple-pattern-items;

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

our class TuplePatternItems {
    has @.patterns;

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

our class GroupedPattern {
    has $.pattern;

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

our class SlicePattern {
    has $.maybe-slice-pattern-items;

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

our class SlicePatternItems {
    has @.patterns;

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

our role TupleStructPattern::Rules {

    rule tuple-struct-pattern {
        <path-in-expression> 
        <tok-lparen> 
        <tuple-struct-items>? 
        <tok-rparen>
    }

    rule tuple-struct-items {
        <pattern>+ %% <tok-comma>
    }

    rule tuple-pattern {
        <tok-lparen> 
        <tuple-pattern-items>? 
        <tok-rparen>
    }

    proto rule tuple-pattern-items { * }

    rule tuple-pattern-items:sym<rest-pat> {
        <rest-pattern>
    }

    rule tuple-pattern-items:sym<pat> {
        <pattern>+ %% <tok-comma>
    }

    rule grouped-pattern {
        <tok-lparen>
        <pattern>
        <tok-rparen>
    }

    rule slice-pattern {
        <tok-lbrack>
        <slice-pattern-items>?
        <tok-rbrack>
    }

    rule slice-pattern-items {
        <pattern>+ %% <tok-comma>
    }

    proto rule path-pattern { * }
    rule path-pattern:sym<a> { <path-in-expression> }
    rule path-pattern:sym<b> { <qualified-path-in-expression> }
}

our role TupleStructPattern::Actions {

    method tuple-struct-pattern($/) {
        <path-in-expression> 
        <tok-lparen> 
        <tuple-struct-items>? 
        <tok-rparen>
    }

    method tuple-struct-items($/) {
        <pattern>+ %% <tok-comma>
    }

    method tuple-pattern($/) {
        <tok-lparen> 
        <tuple-pattern-items>? 
        <tok-rparen>
    }

    method tuple-pattern-items:sym<rest-pat>($/) {
        <rest-pattern>
    }

    method tuple-pattern-items:sym<pat>($/) {
        <pattern>+ %% <tok-comma>
    }

    method grouped-pattern($/) {
        <tok-lparen>
        <pattern>
        <tok-rparen>
    }

    method slice-pattern($/) {
        <tok-lbrack>
        <slice-pattern-items>?
        <tok-rbrack>
    }

    method slice-pattern-items($/) {
        <pattern>+ %% <tok-comma>
    }

    method path-pattern:sym<a>($/) { <path-in-expression> }
    method path-pattern:sym<b>($/) { <qualified-path-in-expression> }
}

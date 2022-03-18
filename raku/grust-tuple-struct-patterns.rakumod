use Data::Dump::Tree;

our class TupleStructPattern {
    has $.path-in-expression;
    has $.maybe-tuple-struct-items;

    has $.text;

    method gist {
        my $builder = $.path-in-expression.gist;

        $builder ~= "(";

        if $.maybe-tuple-struct-items {
            $builder ~= $.maybe-tuple-struct-items.gist;
        }

        $builder ~= ")";

        $builder
    }
}

our class TupleStructItems {
    has @.patterns;

    has $.text;

    method gist {
        @.patterns>>.gist.join(",")
    }
}

our class TuplePattern {
    has $.maybe-tuple-pattern-items;

    has $.text;

    method gist {
        my $builder = "(";

        if $.maybe-tuple-pattern-items {
            $builder ~= $.maybe-tuple-pattern-items.gist;
        }

        $builder ~= ")";
    }
}

our class TuplePatternItems {
    has @.patterns;

    has $.text;

    method gist {
        @.patterns>>.gist.join(",")
    }
}

our class GroupedPattern {
    has $.pattern;

    has $.text;

    method gist {
        "(" ~ $.pattern.gist ~ ")"
    }
}

our class SlicePattern {
    has $.maybe-slice-pattern-items;

    has $.text;

    method gist {

        my $builder = "[";

        if $.maybe-slice-pattern-items {
            $builder ~= $.maybe-slice-pattern-items.gist;
        }

        $builder ~= "]";

        $builder
    }
}

our class SlicePatternItems {
    has @.patterns;

    has $.text;

    method gist {
        @.patterns.join(", ")
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
        make TupleStructPattern.new(
            path-in-expression       => $<path-in-expression>.made,
            maybe-tuple-struct-items => $<tuple-struct-items>.made,
            text                     => $/.Str,
        )
    }

    method tuple-struct-items($/) {
        make $<pattern>>>.made
    }

    method tuple-pattern($/) {
        make TupleStructItems.new(
            patterns => $<tuple-pattern-items>.made,
            text     => $/.Str,
        )
    }

    method tuple-pattern-items:sym<rest-pat>($/) {
        make $<rest-pattern>.made
    }

    method tuple-pattern-items:sym<pat>($/) {
        make $<pattern>>>.made
    }

    method grouped-pattern($/) {
        make GroupedPattern.new(
            pattern => $<pattern>.made,
            text    => $/.Str,
        )
    }

    method slice-pattern($/) {
        make SlicePattern.new(
            maybe-slice-pattern-items => $<slice-pattern-items>.made,
            text                      => $/.Str,
        )
    }

    method slice-pattern-items($/) {
        make $<pattern>>>.made
    }

    method path-pattern:sym<a>($/) { make $<path-in-expression>.made }
    method path-pattern:sym<b>($/) { make $<qualified-path-in-expression>.made }
}

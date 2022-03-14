our class PathInExpression {
    has @.path-expr-segments;

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

our class PathExprSegment {
    has $.path-ident-segment;
    has $.maybe-generic-args;

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

our class DollarCrate {

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

our class QualifiedPathInExpression {
    has $.qualified-path-type;
    has @.path-expr-segments;

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

our class QualifiedPathType {
    has $.type;
    has $.maybe-as-type-path;

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

our class QualifiedPathInType {
    has $.qualified-path-type;
    has @.type-path-segments;

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

our role PathExpression::Rules {

    proto rule path-expression { * }
    rule path-expression:sym<basic>      { <path-in-expression> }
    rule path-expression:sym<qualified>  { <qualified-path-in-expression> }

    token path-in-expression {
        <tok-path-sep>?
        [
            <path-expr-segment>+ %% <tok-path-sep>
        ]
    }

    token path-expr-segment {
        <path-ident-segment> 
        [ <tok-path-sep> <generic-args> ]?
    }

    proto token path-ident-segment { * }

    token path-ident-segment:sym<ident>   { <identifier> }
    token path-ident-segment:sym<super>   { <kw-super> }
    token path-ident-segment:sym<selfv>   { <kw-selfvalue> }
    token path-ident-segment:sym<selft>   { <kw-selftype> }
    token path-ident-segment:sym<crate>   { <kw-crate> }
    token path-ident-segment:sym<$-crate> { <dollar-crate> }

    token dollar-crate {
        <tok-dollar> <kw-crate> 
    }

    token qualified-path-in-expression {
        <qualified-path-type> [<tok-path-sep> <path-expr-segment>]+
    }

    rule qualified-path-type {
        <tok-lt>
        <type>
        [
            <kw-as>
            <type-path>
        ]?
        <tok-gt>
    }

    token qualified-path-in-type {
        <qualified-path-type>
        [
            <tok-path-sep>
            <type-path-segment>
        ]+
    }
}

our role PathExpression::Actions {}

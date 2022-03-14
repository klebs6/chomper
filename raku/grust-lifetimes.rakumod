our class LifetimeToken {
    has $.identifier-or-keyword;

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

our class LifetimeTokenAnonymous { 

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

our class LifetimeOrLabel {
    has $.non-keyword-identifier;

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

our class LifetimeBounds {
    has @.lifetimes;

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

our class Lifetime {
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

our class StaticLifetime  {

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

our class UnnamedLifetime {

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

our class ForLifetimes {
    has @.generic-params;

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

our role Lifetimes::Rules {

    proto token lifetime-token { * }

    token lifetime-token:sym<basic> {
        <tok-single-quote>
        <identifier-or-keyword>
    }

    token lifetime-token:sym<anonymous> {
        <tok-single-quote>
        <tok-underscore>
    }

    token lifetime-or-label {
        <tok-single-quote>
        <non-keyword-identifier>
    }

    rule lifetime-bounds {
        <lifetime>* %% <tok-plus>
    }

    proto token lifetime { * }
    token lifetime:sym<lt>      { <lifetime-or-label> }
    token lifetime:sym<static>  { \' <static> }
    token lifetime:sym<unnamed> { \' _ }

    rule for-lifetimes {
        <kw-for> <generic-params>
    }
}

our role Lifetimes::Actions {}

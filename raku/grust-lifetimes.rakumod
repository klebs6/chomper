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

our class LifetimeTokenAnonymous { }

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

our role Lifetimes::Actions {

    method lifetime-token:sym<basic>($/) {
        make LifetimeToken.new(
            identifier-or-keyword => $<identifier-or-keyword>.made
            text       => $/.Str,
        )
    }

    method lifetime-token:sym<anonymous>($/) {
        make LifetimeTokenAnonymous.new
    }

    method lifetime-or-label($/) {
        make LifetimeOrLabel.new(
            non-keyword-identifier => $<non-keyword-identifier>.made,
            text       => $/.Str,
        )
    }

    method lifetime-bounds($/) {
        make $<lifetime>>>.made
    }

    method lifetime:sym<lt>($/) { 
        make Lifetime.new(
            lifetime-or-label => $<lifetime-or-label>.made
            text       => $/.Str,
        )
    }

    method lifetime:sym<static>($/)  { 
        make StaticLifetime.new
    }

    method lifetime:sym<unnamed>($/) { 
        make UnnamedLifetime.new
    }

    method for-lifetimes($/) {
        make ForLifetimes.new(
            generic-params => $<generic-params>.made
            text       => $/.Str,
        )
    }
}

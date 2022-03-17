use Data::Dump::Tree;

our class LifetimeToken {
    has $.identifier-or-keyword;

    has $.text;

    method gist {
        "'" ~ $.identifier-or-keyword.gist
    }
}

our class LifetimeTokenAnonymous { 
    method gist {
        "'_"
    }
}

our class LifetimeOrLabel {
    has $.non-keyword-identifier;

    has $.text;

    method gist {
        "'" ~ $.non-keyword-identifier.gist
    }
}

our class LifetimeBounds {
    has @.lifetimes;

    has $.text;

    method gist {
        @.lifetimes>>.join(" + ")
    }
}

our class Lifetime {
    has $.lifetime-or-label;

    has $.text;

    method gist {
        $.lifetime-or-label.gist
    }
}

our class StaticLifetime  {

    has $.text;

    method gist {
        "'static"
    }
}

our class UnnamedLifetime {

    has $.text;

    method gist {
        "'_"
    }
}

our class ForLifetimes {
    has @.generic-params;

    has $.text;

    method gist {
        "for " ~ @.generic-params>>.gist.join(" ")
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
            identifier-or-keyword => $<identifier-or-keyword>.made,
            text                  => $/.Str,
        )
    }

    method lifetime-token:sym<anonymous>($/) {
        make LifetimeTokenAnonymous.new
    }

    method lifetime-or-label($/) {
        make LifetimeOrLabel.new(
            non-keyword-identifier => $<non-keyword-identifier>.made,
            text                   => $/.Str,
        )
    }

    method lifetime-bounds($/) {
        make $<lifetime>>>.made
    }

    method lifetime:sym<lt>($/) { 
        make Lifetime.new(
            lifetime-or-label => $<lifetime-or-label>.made,
            text              => $/.Str,
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
            generic-params => $<generic-params>.made,
            text           => $/.Str,
        )
    }
}

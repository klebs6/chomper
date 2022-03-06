our class ViewPathSimple {
    has $.path-no-types-allowed;
    has $.ident;

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

our class ViewPathList {
    has $.idents-or-self;
    has $.path-no-types-allowed;

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

our class ViewPathGlob {
    has $.path-no-types-allowed;

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

our role ViewPath::Rules {

    proto rule view-path { * }

    rule view-path:sym<f> { [<path-no-types-allowed>? <tok-mod-sep>]? '{' [<idents-or-self> ','?]? '}' }
    rule view-path:sym<h> { <path-no-types-allowed> <tok-mod-sep> '*' }
    rule view-path:sym<i> {                         <tok-mod-sep>? '*' }
    rule view-path:sym<n> { <path-no-types-allowed> <kw-as> <ident> }
    rule view-path:sym<a> { <path-no-types-allowed> }

}

our role ViewPath::Actions {

    method view-path:sym<a>($/) {
        make ViewPathSimple.new(
            path-no-types-allowed => $<path-no-types-allowed>.made,
            text                  => ~$/,
        )
    }

    method view-path:sym<f>($/) {
        make ViewPathList.new(
            path-no-types-allowed => $<path-no-types-allowed>.made,
            idents-or-self        => $<idents-or-self>.made,
            text                  => ~$/,
        )
    }

    method view-path:sym<h>($/) {
        make ViewPathGlob.new(
            path-no-types-allowed => $<path-no-types-allowed>.made,
            text                  => ~$/,
        )
    }

    method view-path:sym<i>($/) {
        make ViewPathGlob.new(
            text                  => ~$/,
        )
    }

    method view-path:sym<n>($/) {
        make ViewPathSimple.new(
            path-no-types-allowed => $<path-no-types-allowed>.made,
            ident                 => $<ident>.made,
            text                  => ~$/,
        )
    }
}

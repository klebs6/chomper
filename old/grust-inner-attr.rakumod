use Data::Dump::Tree;

our class InnerAttr {
    has $.meta-item;

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

our class InnerAttrs {
    has $.inner-attr;

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

our role InnerAttrs::Rules {

    rule maybe-inner-attrs {
        <inner-attrs>?
    }

    rule inner-attrs {
        <inner-attr>+
    }

    proto rule inner-attr { * }

    rule inner-attr:sym<a> {
        <shebang> '[' <meta-item> ']'
    }

    rule inner-attr:sym<b> {
        <inner-doc-comment>
    }
}

our role InnerAttrs::Actions {

    method maybe-inner-attrs($/) {
        make $<inner-attrs>.made
    }

    method inner-attrs($/) {
        make $<inner-attr>>>.made
    }

    method inner-attr:sym<a>($/) {
        make InnerAttr.new(
            meta-item => $<meta-item>.made,
            text      => ~$/,
        )
    }

    method inner-attr:sym<b>($/) {
        make $<inner-doc-comment>.made
    }
}

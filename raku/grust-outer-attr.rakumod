use Data::Dump::Tree;

use grust-model;

our role OuterAttrs::Rules {

    rule maybe-outer-attrs {
        <outer-attrs>?
    }

    rule outer-attrs {
        <outer-attr>+
    }

    proto rule outer-attr { * }

    rule outer-attr:sym<a> { '#' '[' <meta-item> ']' }
    rule outer-attr:sym<b> { <outer-doc-comment> }
}

our role OuterAttrs::Actions {

    method maybe-outer-attrs($/) {
        make $<outer-attrs>.made
    }

    method outer-attrs($/) {
        make $<outer-attr>>>.made
    }

    method outer-attr:sym<a>($/) {
        make $<meta-item>.made
    }

    method outer-attr:sym<b>($/) {
        make $<outer-doc-comment>.made
    }
}

use grust-model;


our role OuterAttrs::Rules {

    rule maybe-outer_attrs {
        <outer-attrs>?
    }

    rule outer-attrs {
        <outer-attr>+
    }

    proto rule outer-attr { * }

    rule outer-attr:sym<a> {
        '#' '[' <meta-item> ']'
    }

    rule outer-attr:sym<b> {
        <OUTER-DOC_COMMENT>
    }
}

our role OuterAttrs::Actions {

    method maybe-outer_attrs:sym<a>($/) {
        make $<outer-attrs>.made
    }

    method outer-attrs($/) {
        make $<outer-attr>>>.made
    }

    method outer-attr:sym<a>($/) {
        make $<meta_item>.made
    }

    method outer-attr:sym<b>($/) {
        make doc-comment.new(

        )
    }
}

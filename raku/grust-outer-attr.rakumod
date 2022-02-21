our class OuterAttrs {
    has $.outer_attr;
}

our class OuterAttrs::G {

    proto rule maybe-outer_attrs { * }

    rule maybe-outer_attrs:sym<a> {
        <outer-attrs>
    }

    rule maybe-outer_attrs:sym<b> {

    }

    proto rule outer-attrs { * }

    rule outer-attrs:sym<a> {
        <outer-attr>
    }

    rule outer-attrs:sym<b> {
        <outer-attrs> <outer-attr>
    }

    proto rule outer-attr { * }

    rule outer-attr:sym<a> {
        '#' '[' <meta-item> ']'
    }

    rule outer-attr:sym<b> {
        <OUTER-DOC_COMMENT>
    }
}

our class OuterAttrs::A {

    method maybe-outer_attrs:sym<a>($/) {
        make $<outer-attrs>.made
    }

    method maybe-outer_attrs:sym<b>($/) {
        MkNone<140662032925984>
    }

    method outer-attrs:sym<a>($/) {
        make OuterAttrs.new(
            outer-attr =>  $<outer-attr>.made,
        )
    }

    method outer-attrs:sym<b>($/) {
        ExtNode<140662815349104>
    }

    method outer-attr:sym<a>($/) {
        make $<meta_item>.made
    }

    method outer-attr:sym<b>($/) {
        make doc-comment.new(

        )
    }
}


our class InnerAttr {
    has $.meta_item;
}

our class InnerAttrs {
    has $.inner_attr;
}

our class InnerAttrs::Rules {

    rule maybe-inner-attrs {
        <inner-attrs>?
    }

    rule inner-attrs {
        <inner-attr>+
    }

    proto rule inner-attr { * }

    rule inner-attr:sym<a> {
        <SHEBANG> '[' <meta-item> ']'
    }

    rule inner-attr:sym<b> {
        <INNER-DOC_COMMENT>
    }
}

our class InnerAttrs::Actions {

    method maybe-inner-attrs($/) {
        make $<inner-attrs>.made
    }

    method inner-attrs($/) {
        make $<inner-attr>>>.made
    }

    method inner-attr:sym<a>($/) {
        make InnerAttr.new(
            meta-item =>  $<meta-item>.made,
        )
    }

    method inner-attr:sym<b>($/) {
        make InnerAttr.new(

        )
    }
}

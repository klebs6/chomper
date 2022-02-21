our class InnerAttr {
    has $.meta_item;
}

our class InnerAttrs {
    has $.inner_attr;
}

our class InnerAttrs::Rules {

    proto rule maybe-inner_attrs { * }

    rule maybe-inner_attrs:sym<a> {
        <inner-attrs>
    }

    rule maybe-inner_attrs:sym<b> {

    }

    proto rule inner-attrs { * }

    rule inner-attrs:sym<a> {
        <inner-attr>
    }

    rule inner-attrs:sym<b> {
        <inner-attrs> <inner-attr>
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

    method maybe-inner_attrs:sym<a>($/) {
        make $<inner-attrs>.made
    }

    method maybe-inner_attrs:sym<b>($/) {
        MkNone<140465736753184>
    }

    method inner-attrs:sym<a>($/) {
        make InnerAttrs.new(
            inner-attr =>  $<inner-attr>.made,
        )
    }

    method inner-attrs:sym<b>($/) {
        ExtNode<140465182492136>
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


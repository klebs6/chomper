our role ItemsAndAttributes {
    token maybe-shebang { 
        <SHEBANG_LINE>?
    }
}

#------------------------
our role Crate::G {

    proto token crate { * }

    token crate:sym<A> {  
        <maybe_shebang> 
        <inner_attrs> 
        <maybe_mod_items> 
    }

    token crate:sym<B> {  
        <maybe_shebang> 
        <maybe_mod_items>  
    }
}

our role Crate::A {
    method crate:sym<A>($/) {
        make Crate.new(
            inner_attrs     => $<inner_attrs>.made,
            maybe_mod_items => $<maybe_mod_items>.made,
        )
    }

    method crate:sym<B>($/) {
        make Crate.new(
            maybe_mod_items => $<maybe_mod_items>.made,
        )
    }
}

#------------------------
our role InnerAttrs::G {

    token maybe_inner_attrs {
        <inner_attrs>?
    }

    rule inner_attrs {
        <inner_attr>+
    }

    proto rule inner_attr { * }

    rule inner_attr:sym<shebang-meta> {
        <SHEBANG> '[' <meta_item> ']'   
    }

    rule inner_attr:sym<inner-doc-comment> {
        <INNER_DOC_COMMENT>
    }
}

our role InnerAttrs::A {

    method maybe_inner_attrs($/) {
        make $<inner_attrs>.made
    }

    method inner_attrs($/) {
        make $<inner_attr>>>.made
    }

    method inner_attr:sym<shebang-meta>($/) {
        make InnerAttr.new(
            meta_item => $<meta_item>.made,
        )
    }

    method inner_attr:sym<inner-doc-comment>($/) {
        make InnerAttr.new(
            doc_comment => $/.Str,
        )
    }
}

#------------------------
our role OuterAttrs::G {

    token maybe_outer_attrs {
        <outer_attrs>?
    }

    rule outer_attrs {
        <outer_attr>+
    }

    proto rule outer_attr { * }

    rule outer_attr:sym<bang-meta> {
        '#' '[' <meta_item> ']'    
    }

    rule outer_attr:sym<inner-doc-comment> {
        <OUTER_DOC_COMMENT>        
    }
}

our role OuterAttrs::A {

    method maybe_outer_attrs($/) {
        make $<outer_attrs>.made
    }

    method outer_attrs($/) {
        make $<outer_attr>>>.made
    }

    method outer_attr:sym<bang-meta>($/) {
        make $<meta_item>.made
    }

    method outer_attr:sym<outer-doc-comment>($/) {
        make DocComment.new(
            text => $/.Str,
        )
    }
}

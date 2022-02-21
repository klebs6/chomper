our class ViewItemExternCrate {
    has $.ident;
}

our class ViewItem::Rules {

    proto rule view-item { * }

    rule view-item:sym<a> {
        <use-item>
    }

    rule view-item:sym<b> {
        <extern-fn_item>
    }

    rule view-item:sym<c> {
        <EXTERN> <CRATE> <ident> ';'
    }

    rule view-item:sym<d> {
        <EXTERN> <CRATE> <ident> <AS> <ident> ';'
    }
}

our class ViewItem::Actions {

    method view-item:sym<a>($/) {
        make $<use-item>.made
    }

    method view-item:sym<b>($/) {
        make $<extern-fn_item>.made
    }

    method view-item:sym<c>($/) {
        make ViewItemExternCrate.new(
            ident =>  $<ident>.made,
        )
    }

    method view-item:sym<d>($/) {
        make ViewItemExternCrate.new(
            ident =>  $<ident>.made,
            ident =>  $<ident>.made,
        )
    }
}


use grust-model;

our role ViewItem::Rules {

    proto rule view-item { * }

    rule view-item:sym<a> { <use-item> }
    rule view-item:sym<b> { <extern-fn-item> }
    rule view-item:sym<c> { <kw-extern> <kw-crate> <ident> ';' }
    rule view-item:sym<d> { <kw-extern> <kw-crate> <ident> <kw-as> <ident> ';' }
}

our role ViewItem::Actions {

    method view-item:sym<a>($/) {
        make $<use-item>.made
    }

    method view-item:sym<b>($/) {
        make $<extern-fn-item>.made
    }

    method view-item:sym<c>($/) {
        make ViewItemExternCrate.new(
            ident =>  $<ident>.made,
            text  => ~$/,
        )
    }

    method view-item:sym<d>($/) {
        make ViewItemExternCrate.new(
            ident    => $<ident>>>.made[0],
            as-ident => $<ident>>>.made[1],
            text     => ~$/,
        )
    }
}

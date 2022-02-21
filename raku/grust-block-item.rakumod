our class ItemForeignMod {
    has $.inner_attrs;
    has $.item_foreign_mod;
    has $.maybe_foreign_items;
}

our class BlockItem::Rules {

    proto rule block-item { * }

    rule block-item:sym<a> {
        <item-fn>
    }

    rule block-item:sym<b> {
        <item-unsafe_fn>
    }

    rule block-item:sym<c> {
        <item-mod>
    }

    rule block-item:sym<d> {
        <item-foreign_mod>
    }

    rule block-item:sym<e> {
        <item-struct>
    }

    rule block-item:sym<f> {
        <item-enum>
    }

    rule block-item:sym<g> {
        <item-union>
    }

    rule block-item:sym<h> {
        <item-trait>
    }

    rule block-item:sym<i> {
        <item-impl>
    }
}

our class BlockItem::Actions {

    method block-item:sym<a>($/) {
        make $<item-fn>.made
    }

    method block-item:sym<b>($/) {
        make $<item-unsafe_fn>.made
    }

    method block-item:sym<c>($/) {
        make $<item-mod>.made
    }

    method block-item:sym<d>($/) {
        make ItemForeignMod.new(
            item-foreign_mod =>  $<item-foreign_mod>.made,
        )
    }

    method block-item:sym<e>($/) {
        make $<item-struct>.made
    }

    method block-item:sym<f>($/) {
        make $<item-enum>.made
    }

    method block-item:sym<g>($/) {
        make $<item-union>.made
    }

    method block-item:sym<h>($/) {
        make $<item-trait>.made
    }

    method block-item:sym<i>($/) {
        make $<item-impl>.made
    }
}

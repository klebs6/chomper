our class ItemMod {
    has $.ident;
    has $.maybe_mod_items;
    has $.inner_attrs;
}

our class ItemMod::Rules {

    proto rule item-mod { * }

    rule item-mod:sym<a> {
        <MOD> <ident> ';'
    }

    rule item-mod:sym<b> {
        <MOD> <ident> '{' <maybe-mod_items> '}'
    }

    rule item-mod:sym<c> {
        <MOD> <ident> '{' <inner-attrs> <maybe-mod_items> '}'
    }

    proto rule item-foreign_mod { * }

    rule item-foreign_mod:sym<a> {
        <EXTERN> <maybe-abi> '{' <maybe-foreign_items> '}'
    }

    rule item-foreign_mod:sym<b> {
        <EXTERN> <maybe-abi> '{' <inner-attrs> <maybe-foreign_items> '}'
    }

    proto rule maybe-abi { * }

    rule maybe-abi:sym<a> {
        <str>
    }

    rule maybe-abi:sym<b> {

    }
}

our class ItemMod::Actions {

    method item-mod:sym<a>($/) {
        make ItemMod.new(
            ident =>  $<ident>.made,
        )
    }

    method item-mod:sym<b>($/) {
        make ItemMod.new(
            ident           =>  $<ident>.made,
            maybe-mod_items =>  $<maybe-mod_items>.made,
        )
    }

    method item-mod:sym<c>($/) {
        make ItemMod.new(
            ident           =>  $<ident>.made,
            inner-attrs     =>  $<inner-attrs>.made,
            maybe-mod_items =>  $<maybe-mod_items>.made,
        )
    }

    method item-foreign_mod:sym<a>($/) {
        make ItemForeignMod.new(
            maybe-foreign_items =>  $<maybe-foreign_items>.made,
        )
    }

    method item-foreign_mod:sym<b>($/) {
        make ItemForeignMod.new(
            inner-attrs         =>  $<inner-attrs>.made,
            maybe-foreign_items =>  $<maybe-foreign_items>.made,
        )
    }

    method maybe-abi:sym<a>($/) {
        make $<str>.made
    }

    method maybe-abi:sym<b>($/) {
        MkNone<140304314189184>
    }
}


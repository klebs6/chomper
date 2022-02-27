use grust-model;


our role ItemMod::Rules {

    proto rule item-mod { * }

    rule item-mod:sym<a> {
        <MOD> <ident> ';'
    }

    rule item-mod:sym<b> {
        <MOD> <ident> '{' <inner-attrs>? <maybe-mod_items> '}'
    }

    rule item-foreign_mod {
        <EXTERN> <maybe-abi> '{' <inner-attrs>? <maybe-foreign_items> '}'
    }

    rule maybe-abi {
        <str>?
    }
}

our role ItemMod::Actions {

    method item-mod:sym<a>($/) {
        make ItemMod.new(
            ident =>  $<ident>.made,
        )
    }

    method item-mod:sym<b>($/) {
        make ItemMod.new(
            ident           =>  $<ident>.made,
            inner-attrs     =>  $<inner-attrs>.made,
            maybe-mod_items =>  $<maybe-mod_items>.made,
        )
    }

    method item-foreign_mod($/) {
        make ItemForeignMod.new(
            inner-attrs         =>  $<inner-attrs>.made,
            maybe-foreign_items =>  $<maybe-foreign_items>.made,
        )
    }

    method maybe-abi($/) {
        make $<str>.made
    }
}

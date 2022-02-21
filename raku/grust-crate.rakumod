
our class Crate {
    has $.maybe_mod_items;
    has $.inner_attrs;
}

our class Crate::Rules {

    proto rule crate { * }

    rule crate:sym<a> {
        <maybe-shebang> <inner-attrs> <maybe-mod_items>
    }

    rule crate:sym<b> {
        <maybe-shebang> <maybe-mod_items>
    }

    proto rule maybe-shebang { * }

    rule maybe-shebang:sym<a> {
        <SHEBANG-LINE>
    }

    rule maybe-shebang:sym<b> {

    }
}

our class Crate::Actions {

    method crate:sym<a>($/) {
        make crate.new(
            inner-attrs     =>  $<inner-attrs>.made,
            maybe-mod_items =>  $<maybe-mod_items>.made,
        )
    }

    method crate:sym<b>($/) {
        make crate.new(
            maybe-mod_items =>  $<maybe-mod_items>.made,
        )
    }

    method maybe-shebang:sym<a>($/) {
        make $<SHEBANG-LINE>.made
    }

    method maybe-shebang:sym<b>($/) {

    }
}

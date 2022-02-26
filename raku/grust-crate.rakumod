
our class Crate {
    has $.maybe_mod-items;
    has $.inner_attrs;
}

our class Crate::Rules {

    rule crate {
        <maybe-shebang> 
        <inner-attrs>? 
        <maybe-mod-items>
    }

    rule maybe-shebang {
        <SHEBANG-LINE>?
    }
}

our class Crate::Actions {

    method crate($/) {
        make crate.new(
            inner-attrs     =>  $<inner-attrs>.made // Nil,
            maybe-mod-items =>  $<maybe-mod-items>.made,
        )
    }

    method maybe-shebang($/) {
        make $<SHEBANG-LINE>.made
    }
}

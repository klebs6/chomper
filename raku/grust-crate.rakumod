use grust-model;

our role Crate::Rules {

    rule crate {
        <maybe-shebang> 
        <inner-attrs>? 
        <maybe-mod-items>
    }

    rule maybe-shebang {
        <SHEBANG-LINE>?
    }
}

our role Crate::Actions {

    method crate($/) {
        make Crate.new(
            inner-attrs     =>  $<inner-attrs>.made // Nil,
            maybe-mod-items =>  $<maybe-mod-items>.made,
        )
    }

    method maybe-shebang($/) {
        make $<SHEBANG-LINE>.made
    }
}

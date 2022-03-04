use grust-model;

our role ConstGenerics::Rules {

    rule const-generic {
        <kw-const> <ident> <ty-ascription>
    }

    rule const-generics {
        <const-generic>+ %% ","
    }
}

our role ConstGenerics::Actions {

    method const-generic($/) {
        make ConstGeneric.new(
            name => $<ident>.made,
            ty   => $<ty-ascription>.made,
        )
    }

    method const-generics($/) {
        make $<const-generic>>>.made
    }
}


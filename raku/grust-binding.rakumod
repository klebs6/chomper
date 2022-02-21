our class Binding {
    has $.ty;
    has $.ident;
}

our role Binding::Rules {

    rule bindings {
        <binding>+ %% <comma>
    }

    rule binding {
        <ident> '=' <ty>
    }
}

our role Binding::Actions {

    method bindings($/) {
        make $<binding>>>.made
    }

    method binding($/) {
        make Binding.new(
            ident =>  $<ident>.made,
            ty    =>  $<ty>.made,
        )
    }
}

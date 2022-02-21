our class Binding {
    has $.ty;
    has $.ident;
}

our class Bindings {
    has $.binding;
}

our class Binding::Rules {

    rule bindings {
        <binding>+ %% <comma>
    }

    rule binding {
        <ident> '=' <ty>
    }
}

our class Binding::Actions {

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

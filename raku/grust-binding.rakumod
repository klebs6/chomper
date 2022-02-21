our class Binding {
    has $.ty;
    has $.ident;
}

our class Bindings {
    has $.binding;
}

our class Binding::G {

    proto rule bindings { * }

    rule bindings:sym<a> {
        <binding>
    }

    rule bindings:sym<b> {
        <bindings> ',' <binding>
    }

    rule binding {
        <ident> '=' <ty>
    }
}

our class Binding::A {

    method bindings:sym<a>($/) {
        make Bindings.new(
            binding =>  $<binding>.made,
        )
    }

    method bindings:sym<b>($/) {
        ExtNode<140351397766456>
    }

    method binding($/) {
        make Binding.new(
            ident =>  $<ident>.made,
            ty    =>  $<ty>.made,
        )
    }
}

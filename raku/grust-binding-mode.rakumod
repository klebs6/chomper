
our class BindingMode::Rules {

    proto rule binding-mode { * }

    rule binding-mode:sym<a> {
        <REF>
    }

    rule binding-mode:sym<b> {
        <REF> <MUT>
    }

    rule binding-mode:sym<c> {
        <MUT>
    }
}

our class BindingMode::Actions {

    method binding-mode:sym<a>($/) {
        make BindByRef.new(

        )
    }

    method binding-mode:sym<b>($/) {
        make BindByRef.new(

        )
    }

    method binding-mode:sym<c>($/) {
        make BindByValue.new(

        )
    }
}

use grust-model;

our role Binding::Rules {

    rule bindings {
        <binding>+ %% <tok-comma>
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

#----------------------------
our role BindingMode::Rules {

    proto rule binding-mode { * }
    rule binding-mode:sym<ref-mut> { <kw-ref> <kw-mut> }
    rule binding-mode:sym<kw-ref>  { <kw-ref> }
    rule binding-mode:sym<kw-mut>  { <kw-mut> }
}

our role BindingMode::Actions {

    method binding-mode:sym<kw-ref>($/)  { make BindByRef.new(  mut => False) }
    method binding-mode:sym<ref-mut>($/) { make BindByRef.new(  mut => True) }
    method binding-mode:sym<kw-mut>($/)  { make BindByValue.new(mut => True) }
}

use grust-model;

our role BindingMode::Rules {

    proto rule binding-mode { * }
    rule binding-mode:sym<kw-ref>  { <kw-ref> }
    rule binding-mode:sym<ref-mut> { <kw-ref> <kw-mut> }
    rule binding-mode:sym<kw-mut>  { <kw-mut> }
}

our role BindingMode::Actions {

    method binding-mode:sym<kw-ref>($/)     { make BindByRef.new() }
    method binding-mode:sym<ref-mut>($/) { make BindByRef.new() }
    method binding-mode:sym<kw-mut>($/)     { make BindByValue.new() }
}

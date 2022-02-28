use grust-model;

our role BindingMode::Rules {

    proto rule binding-mode { * }
    rule binding-mode:sym<ref>     { <ref> }
    rule binding-mode:sym<ref-mut> { <ref> <mut> }
    rule binding-mode:sym<mut>     { <mut> }
}

our role BindingMode::Actions {

    method binding-mode:sym<ref>($/)     { make BindByRef.new() }
    method binding-mode:sym<ref-mut>($/) { make BindByRef.new() }
    method binding-mode:sym<mut>($/)     { make BindByValue.new() }
}

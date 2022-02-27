use grust-model;

our role BindingMode::Rules {

    proto rule binding-mode { * }
    rule binding-mode:sym<ref>     { <REF> }
    rule binding-mode:sym<ref-mut> { <REF> <MUT> }
    rule binding-mode:sym<mut>     { <MUT> }
}

our role BindingMode::Actions {

    method binding-mode:sym<ref>($/)     { make BindByRef.new() }
    method binding-mode:sym<ref-mut>($/) { make BindByRef.new() }
    method binding-mode:sym<mut>($/)     { make BindByValue.new() }
}

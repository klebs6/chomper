use grust-model;

our role FnDeclWithSelf::Rules {

    rule fn-decl {
        <fn-params> <ret-ty>
    }

    rule fn-decl_with_self {
        <fn-params_with_self> <ret-ty>
    }

    rule fn-decl_with_self_allow_anon_params {
        <fn-anon_params_with_self> <ret-ty>
    }
}

our role FnDeclWithSelf::Actions {

    method fn-decl($/) {
        make FnDecl.new(
            fn-params =>  $<fn-params>.made,
            ret-ty    =>  $<ret-ty>.made,
        )
    }

    method fn-decl_with_self($/) {
        make FnDecl.new(
            fn-params_with_self =>  $<fn-params_with_self>.made,
            ret-ty              =>  $<ret-ty>.made,
        )
    }

    method fn-decl_with_self_allow_anon_params($/) {
        make FnDecl.new(
            fn-anon_params_with_self =>  $<fn-anon_params_with_self>.made,
            ret-ty                   =>  $<ret-ty>.made,
        )
    }
}

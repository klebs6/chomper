use grust-model;

our role FnDeclWithSelf::Rules {

    rule fn-decl {
        <fn-params> <ret-ty>
    }

    rule fn-decl-with-self {
        <fn-params-with-self> 
        <ret-ty>
    }

    rule fn-decl-with-self-allow-anon-params {
        <fn-anon-params-with-self> 
        <ret-ty>
    }
}

our role FnDeclWithSelf::Actions {

    method fn-decl($/) {
        make FnDecl.new(
            fn-params =>  $<fn-params>.made,
            ret-ty    =>  $<ret-ty>.made,
        )
    }

    method fn-decl-with-self($/) {
        make FnDecl.new(
            fn-params-with-self =>  $<fn-params-with-self>.made,
            ret-ty              =>  $<ret-ty>.made,
        )
    }

    method fn-decl-with-self-allow-anon-params($/) {
        make FnDecl.new(
            fn-anon-params-with-self =>  $<fn-anon-params-with-self>.made,
            ret-ty                   =>  $<ret-ty>.made,
        )
    }
}

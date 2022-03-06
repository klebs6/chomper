
our class FnDecl {
    has $.fn-anon-params-with-self;
    has $.fn-params;
    has $.fn-params-allow-variadic;
    has $.fn-params-with-self;
    has $.ret-ty;

    has $.text;

    submethod TWEAK {
        say self.gist;
    }

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

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

    rule fn-decl-allow-variadic {
        <fn-params-allow-variadic> <ret-ty>
    }
}

our role FnDeclWithSelf::Actions {

    method fn-decl($/) {
        make FnDecl.new(
            fn-params =>  $<fn-params>.made,
            ret-ty    =>  $<ret-ty>.made,
            text      => ~$/,
        )
    }

    method fn-decl-with-self($/) {
        make FnDecl.new(
            fn-params-with-self =>  $<fn-params-with-self>.made,
            ret-ty              =>  $<ret-ty>.made,
            text                => ~$/,
        )
    }

    method fn-decl-with-self-allow-anon-params($/) {
        make FnDecl.new(
            fn-anon-params-with-self =>  $<fn-anon-params-with-self>.made,
            ret-ty                   =>  $<ret-ty>.made,
            text                     => ~$/,
        )
    }

    method fn-decl-allow-variadic($/) {
        make FnDecl.new(
            fn-params-allow-variadic =>  $<fn-params-allow-variadic>.made,
            ret-ty                   =>  $<ret-ty>.made,
            text                     => ~$/,
        )
    }
}

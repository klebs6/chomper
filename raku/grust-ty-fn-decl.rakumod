our class TyFnDecl {
    has $.fn-anon-params;
    has $.ret-ty;
    has $.generic-params;

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

our role TyFnDecl::Rules {

    rule ty-fn-decl {
        <generic-params> 
        <fn-anon-params> 
        <ret-ty>
    }
}

our role TyFnDecl::Actions {

    method ty-fn-decl($/) {
        make TyFnDecl.new(
            generic-params => $<generic-params>.made,
            fn-anon-params => $<fn-anon-params>.made,
            ret-ty         => $<ret-ty>.made,
            text           => ~$/,
        )
    }
}

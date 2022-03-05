use grust-model;

our role TyBareFn::Rules {

    proto rule ty-bare-fn { * }

    rule ty-bare-fn:sym<fn>            { <kw-fn> <ty-fn-decl> }
    rule ty-bare-fn:sym<unsafe-fn>     { <kw-unsafe> <kw-fn> <ty-fn-decl> }
    rule ty-bare-fn:sym<extern>        { <kw-extern> <maybe-abi> <kw-fn> <ty-fn-decl> }
    rule ty-bare-fn:sym<unsafe-extern> { <kw-unsafe> <kw-extern> <maybe-abi> <kw-fn> <ty-fn-decl> }
}

our role TyBareFn::Actions {

    method ty-bare-fn:sym<fn>($/) { 
        make TyBareFn.new(
            decl => $<ty-fn-decl>.made ,
        )
    }

    method ty-bare-fn:sym<unsafe-fn>($/) { 
        make TyBareFn.new(
            decl   => $<ty-fn-decl>.made ,
            unsafe => True,
        )
    }

    method ty-bare-fn:sym<extern>($/) { 
        make TyBareFn.new(
            decl => $<ty-fn-decl>.made ,
            extern => True,
        )
    }

    method ty-bare-fn:sym<unsafe-extern>($/) { 
        make TyBareFn.new(
            decl   => $<ty-fn-decl>.made ,
            unsafe => True,
            extern => True,
        )
    }
}

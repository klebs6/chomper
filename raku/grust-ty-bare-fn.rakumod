use grust-model;

our role TyBareFn::Rules {

    proto rule ty-bare-fn { * }

    rule ty-bare-fn:sym<fn>            { <fn> <ty-fn-decl> }
    rule ty-bare-fn:sym<unsafe-fn>     { <unsafe> <fn> <ty-fn-decl> }
    rule ty-bare-fn:sym<extern>        { <extern> <maybe-abi> <fn> <ty-fn-decl> }
    rule ty-bare-fn:sym<unsafe-extern> { <unsafe> <extern> <maybe-abi> <fn> <ty-fn-decl> }
}

our role TyBareFn::Actions {

    method ty-bare-fn:sym<fn>($/)            { make $<ty-fn-decl>.made }
    method ty-bare-fn:sym<unsafe-fn>($/)     { make $<ty-fn-decl>.made }
    method ty-bare-fn:sym<extern>($/)        { make $<ty-fn-decl>.made }
    method ty-bare-fn:sym<unsafe-extern>($/) { make $<ty-fn-decl>.made }
}

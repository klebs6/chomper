use grust-model;

our role TyBareFn::Rules {

    proto rule ty-bare-fn { * }

    rule ty-bare-fn:sym<fn>            { <FN> <ty-fn-decl> }
    rule ty-bare-fn:sym<unsafe-fn>     { <UNSAFE> <FN> <ty-fn-decl> }
    rule ty-bare-fn:sym<extern>        { <EXTERN> <maybe-abi> <FN> <ty-fn-decl> }
    rule ty-bare-fn:sym<unsafe-extern> { <UNSAFE> <EXTERN> <maybe-abi> <FN> <ty-fn-decl> }
}

our role TyBareFn::Actions {

    method ty-bare-fn:sym<fn>($/)            { make $<ty-fn-decl>.made }
    method ty-bare-fn:sym<unsafe-fn>($/)     { make $<ty-fn-decl>.made }
    method ty-bare-fn:sym<extern>($/)        { make $<ty-fn-decl>.made }
    method ty-bare-fn:sym<unsafe-extern>($/) { make $<ty-fn-decl>.made }
}

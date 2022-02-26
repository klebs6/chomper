our class TyBareFn::Rules {

    proto rule ty-bare_fn { * }

    rule ty-bare_fn:sym<fn>            { <FN> <ty-fn_decl> }
    rule ty-bare_fn:sym<unsafe-fn>     { <UNSAFE> <FN> <ty-fn_decl> }
    rule ty-bare_fn:sym<extern>        { <EXTERN> <maybe-abi> <FN> <ty-fn_decl> }
    rule ty-bare_fn:sym<unsafe-extern> { <UNSAFE> <EXTERN> <maybe-abi> <FN> <ty-fn_decl> }
}

our class TyBareFn::Actions {

    method ty-bare_fn:sym<fn>($/)            { make $<ty_fn_decl>.made }
    method ty-bare_fn:sym<unsafe-fn>($/)     { make $<ty_fn_decl>.made }
    method ty-bare_fn:sym<extern>($/)        { make $<ty_fn_decl>.made }
    method ty-bare_fn:sym<unsafe-extern>($/) { make $<ty_fn_decl>.made }
}

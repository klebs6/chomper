our class TyBareFn::Rules {

    proto rule ty-bare_fn { * }

    rule ty-bare_fn:sym<a> {
        <FN> <ty-fn_decl>
    }

    rule ty-bare_fn:sym<b> {
        <UNSAFE> <FN> <ty-fn_decl>
    }

    rule ty-bare_fn:sym<c> {
        <EXTERN> <maybe-abi> <FN> <ty-fn_decl>
    }

    rule ty-bare_fn:sym<d> {
        <UNSAFE> <EXTERN> <maybe-abi> <FN> <ty-fn_decl>
    }
}

our class TyBareFn::Actions {

    method ty-bare_fn:sym<a>($/) {
        make $<ty_fn_decl>.made
    }

    method ty-bare_fn:sym<b>($/) {
        make $<ty_fn_decl>.made
    }

    method ty-bare_fn:sym<c>($/) {
        make $<ty_fn_decl>.made
    }

    method ty-bare_fn:sym<d>($/) {
        make $<ty_fn_decl>.made
    }
}

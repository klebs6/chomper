our class TyBareFn {
    has Bool $.unsafe = False;
    has Bool $.extern = False;
    has $.decl;

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
            decl => $<ty-fn-decl>.made,
            text => ~$/,
        )
    }

    method ty-bare-fn:sym<unsafe-fn>($/) { 
        make TyBareFn.new(
            decl   => $<ty-fn-decl>.made ,
            unsafe => True,
            text   => ~$/,
        )
    }

    method ty-bare-fn:sym<extern>($/) { 
        make TyBareFn.new(
            decl   => $<ty-fn-decl>.made,
            extern => True,
            text   => ~$/,
        )
    }

    method ty-bare-fn:sym<unsafe-extern>($/) { 
        make TyBareFn.new(
            decl   => $<ty-fn-decl>.made,
            unsafe => True,
            extern => True,
            text   => ~$/,
        )
    }
}

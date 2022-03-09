use Data::Dump::Tree;

our class TyInfer { 

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

our class TyTypeof {
    has $.expr;

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

our class TyFixedLengthVec {
    has $.expr;
    has $.ty;

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

our class TyPath {
    has $.path-generic-args-without-colons;

    has $.text;

    submethod TWEAK {
        self.gist;
    }

    method gist {
        $.path-generic-args-without-colons.gist
    }
}

our class TyMacro {
    has $.path-generic-args-without-colons;
    has $.delimited-token-trees;
    has $.maybe-ident;

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

our class TyBox {
    has $.ty;

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

our class TyPtr {
    has $.maybe-mut-or-const;
    has $.ty;

    has $.text;

    method gist {
        "*" ~ $.maybe-mut-or-const.gist ~ " " ~ $.ty.gist
    }
}

our class TyRptr {
    has $.ty;
    has $.mut;
    has $.lifetime;
    has $.count = 1;

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

our class TyVec {
    has $.ty;

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

our role TyPrim::Rules {

    proto rule ty-prim { * }

    rule ty-prim:sym<f> { <kw-box> <ty> }

    rule ty-prim:sym<g> { '*' <maybe-mut-or-const> <ty> }

    rule ty-prim:sym<i> { '&' <kw-mut> <ty> }
    rule ty-prim:sym<h> { '&' <ty> }

    rule ty-prim:sym<k> { <tok-andand> <kw-mut> <ty> }
    rule ty-prim:sym<j> { <tok-andand> <ty> }

    rule ty-prim:sym<l> { '&' <lifetime> <maybe-mut> <ty> }

    rule ty-prim:sym<m> { <tok-andand> <lifetime> <maybe-mut> <ty> }

    rule ty-prim:sym<n> { '[' <ty> ']' }
    rule ty-prim:sym<o> { '[' <ty> ',' <tok-dotdot> <expr> ']' }
    rule ty-prim:sym<p> { '[' <ty> ';' <expr> ']' }

    rule ty-prim:sym<q> { <kw-typeof> '(' <expr> ')' }
    rule ty-prim:sym<r> { <tok-underscore> }
    rule ty-prim:sym<s> { <ty-bare-fn> }
    rule ty-prim:sym<t> { <for-in-type> }

    rule ty-prim:sym<d> { 
        <path-generic-args-without-colons> 
        '!' 
        <maybe-ident> 
        <delimited-token-trees> 
    }

    rule ty-prim:sym<e> {
        <tok-mod-sep> 
        <path-generic-args-without-colons> 
        '!' 
        <maybe-ident> 
        <delimited-token-trees> 
    }

    rule ty-prim:sym<a> { 
        <path-generic-args-without-colons> 
    }

    rule ty-prim:sym<b> { 
        <tok-mod-sep> 
        <path-generic-args-without-colons> 
    }

    rule ty-prim:sym<c> { 
        <kw-self> 
        <tok-mod-sep> 
        <path-generic-args-without-colons> 
    }
}

our role TyPrim::Actions {

    method ty-prim:sym<a>($/) {
        make TyPath.new(
            path-generic-args-without-colons =>  $<path-generic-args-without-colons>.made,
            text                             => ~$/,
        )
    }

    method ty-prim:sym<b>($/) {
        make TyPath.new(
            path-generic-args-without-colons =>  $<path-generic-args-without-colons>.made,
            text                             => ~$/,
        )
    }

    method ty-prim:sym<c>($/) {
        make TyPath.new(
            path-generic-args-without-colons =>  $<path-generic-args-without-colons>.made,
            text                             => ~$/,
        )
    }

    method ty-prim:sym<d>($/) {
        make TyMacro.new(
            path-generic-args-without-colons =>  $<path-generic-args-without-colons>.made,
            maybe-ident                      =>  $<maybe-ident>.made,
            delimited-token-trees            =>  $<delimited-token-trees>.made,
            text                             => ~$/,
        )
    }

    method ty-prim:sym<e>($/) {
        make TyMacro.new(
            path-generic-args-without-colons =>  $<path-generic-args-without-colons>.made,
            maybe-ident                      =>  $<maybe-ident>.made,
            delimited-token-trees            =>  $<delimited-token-trees>.made,
            text                             => ~$/,
        )
    }

    method ty-prim:sym<f>($/) {
        make TyBox.new(
            ty   => $<ty>.made,
            text => ~$/,
        )
    }

    method ty-prim:sym<g>($/) {
        make TyPtr.new(
            maybe-mut-or-const =>  $<maybe-mut-or-const>.made,
            ty                 =>  $<ty>.made,
            text               => ~$/,
        )
    }

    method ty-prim:sym<h>($/) {
        make TyRptr.new(
            ty   => $<ty>.made,
            text => ~$/,
        )
    }

    method ty-prim:sym<i>($/) {
        make TyRptr.new(
            mut  => True,
            ty   => $<ty>.made,
            text => ~$/,
        )
    }

    method ty-prim:sym<j>($/) {
        make TyRptr.new(
            ty       => $<ty>.made,
            count    => 2,
            text     => ~$/,
        )
    }

    method ty-prim:sym<k>($/) {
        make TyRptr.new(
            mut      => $<maybe-mut>.made,
            ty       => $<ty>.made,
            count    => 2,
            text     => ~$/,
        )
    }

    method ty-prim:sym<l>($/) {
        make TyRptr.new(
            lifetime =>  $<lifetime>.made,
            mut      =>  $<maybe-mut>.made,
            ty       =>  $<ty>.made,
            text     => ~$/,
        )
    }

    method ty-prim:sym<m>($/) {
        make TyRptr.new(
            lifetime => $<lifetime>.made,
            mut      => $<maybe-mut>.made,
            ty       => $<ty>.made,
            count    => 2,
            text     => ~$/,
        )
    }

    method ty-prim:sym<n>($/) {
        make TyVec.new(
            ty   =>  $<ty>.made,
            text => ~$/,
        )
    }

    method ty-prim:sym<o>($/) {
        make TyFixedLengthVec.new(
            ty   =>  $<ty>.made,
            expr =>  $<expr>.made,
            text => ~$/,
        )
    }

    method ty-prim:sym<p>($/) {
        make TyFixedLengthVec.new(
            ty   =>  $<ty>.made,
            expr =>  $<expr>.made,
            text => ~$/,
        )
    }

    method ty-prim:sym<q>($/) {
        make TyTypeof.new(
            expr => $<expr>.made,
            text => ~$/,
        )
    }

    method ty-prim:sym<r>($/) {
        make TyInfer.new(
            text => ~$/,
        )
    }

    method ty-prim:sym<s>($/) {
        make $<ty-bare-fn>.made
    }

    method ty-prim:sym<t>($/) {
        make $<for-in-type>.made
    }
}

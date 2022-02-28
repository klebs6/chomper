use grust-model;

our role TyPrim::Rules {

    proto rule ty-prim { * }

    rule ty-prim:sym<a> { 
        #{self.set-prec(IDENT)} 
        <path-generic-args-without-colons> 
    }

    rule ty-prim:sym<b> { 
        #{self.set-prec(IDENT)} 
        <tok-mod-sep> 
        <path-generic-args-without-colons> 
    }

    rule ty-prim:sym<c> { 
        #{self.set-prec(IDENT)} 
        <kw-self> 
        <tok-mod-sep> 
        <path-generic-args-without-colons> 
    }

    rule ty-prim:sym<d> { 
        #{self.set-prec(IDENT)} 
        <path-generic-args-without-colons> 
        '!' 
        <maybe-ident> 
        <delimited-token-trees> 
    }

    rule ty-prim:sym<e> {
        #{self.set-prec(IDENT)} 
        <tok-mod-sep> 
        <path-generic-args-without-colons> 
        '!' 
        <maybe-ident> 
        <delimited-token-trees> 
    }

    rule ty-prim:sym<f> { <kw-box> <ty> }
    rule ty-prim:sym<g> { '*' <maybe-mut-or-const> <ty> }
    rule ty-prim:sym<h> { '&' <ty> }
    rule ty-prim:sym<i> { '&' <kw-mut> <ty> }
    rule ty-prim:sym<j> { <tok-andand> <ty> }
    rule ty-prim:sym<k> { <tok-andand> <kw-mut> <ty> }
    rule ty-prim:sym<l> { '&' <lifetime> <maybe-mut> <ty> }
    rule ty-prim:sym<m> { <tok-andand> <lifetime> <maybe-mut> <ty> }
    rule ty-prim:sym<n> { '[' <ty> ']' }
    rule ty-prim:sym<o> { '[' <ty> ',' <tok-dotdot> <expr> ']' }
    rule ty-prim:sym<p> { '[' <ty> ';' <expr> ']' }
    rule ty-prim:sym<q> { <kw-typeof> '(' <expr> ')' }
    rule ty-prim:sym<r> { <tok-underscore> }
    rule ty-prim:sym<s> { <ty-bare-fn> }
    rule ty-prim:sym<t> { <for-in-type> }
}

our role TyPrim::Actions {

    method ty-prim:sym<a>($/) {
        make TyPath.new(
            path-generic-args-without-colons =>  $<path-generic-args-without-colons>.made,
        )
    }

    method ty-prim:sym<b>($/) {
        make TyPath.new(
            path-generic-args-without-colons =>  $<path-generic-args-without-colons>.made,
        )
    }

    method ty-prim:sym<c>($/) {
        make TyPath.new(
            path-generic-args-without-colons =>  $<path-generic-args-without-colons>.made,
        )
    }

    method ty-prim:sym<d>($/) {
        make TyMacro.new(
            path-generic-args-without-colons =>  $<path-generic-args-without-colons>.made,
            maybe-ident                      =>  $<maybe-ident>.made,
            delimited-token-trees            =>  $<delimited-token-trees>.made,
        )
    }

    method ty-prim:sym<e>($/) {
        make TyMacro.new(
            path-generic-args-without-colons =>  $<path-generic-args-without-colons>.made,
            maybe-ident                      =>  $<maybe-ident>.made,
            delimited-token-trees            =>  $<delimited-token-trees>.made,
        )
    }

    method ty-prim:sym<f>($/) {
        make TyBox.new(
            ty =>  $<ty>.made,
        )
    }

    method ty-prim:sym<g>($/) {
        make TyPtr.new(
            maybe-mut-or-const =>  $<maybe-mut-or-const>.made,
            ty                 =>  $<ty>.made,
        )
    }

    method ty-prim:sym<h>($/) {
        make TyRptr.new(
            ty =>  $<ty>.made,
        )
    }

    method ty-prim:sym<i>($/) {
        make TyRptr.new(
            ty =>  $<ty>.made,
        )
    }

    method ty-prim:sym<j>($/) {
        make TyRptr.new(

        )
    }

    method ty-prim:sym<k>($/) {
        make TyRptr.new(

        )
    }

    method ty-prim:sym<l>($/) {
        make TyRptr.new(
            lifetime  =>  $<lifetime>.made,
            maybe-mut =>  $<maybe-mut>.made,
            ty        =>  $<ty>.made,
        )
    }

    method ty-prim:sym<m>($/) {
        make TyRptr.new(

        )
    }

    method ty-prim:sym<n>($/) {
        make TyVec.new(
            ty =>  $<ty>.made,
        )
    }

    method ty-prim:sym<o>($/) {
        make TyFixedLengthVec.new(
            ty   =>  $<ty>.made,
            expr =>  $<expr>.made,
        )
    }

    method ty-prim:sym<p>($/) {
        make TyFixedLengthVec.new(
            ty   =>  $<ty>.made,
            expr =>  $<expr>.made,
        )
    }

    method ty-prim:sym<q>($/) {
        make TyTypeof.new(
            expr =>  $<expr>.made,
        )
    }

    method ty-prim:sym<r>($/) {
        make TyInfer.new
    }

    method ty-prim:sym<s>($/) {
        make $<ty-bare-fn>.made
    }

    method ty-prim:sym<t>($/) {
        make $<for-in-type>.made
    }
}

our class TyBox {
    has $.ty;
}

our class TyFixedLengthVec {
    has $.expr;
    has $.ty;
}

our class TyMacro {
    has $.path_generic_args_without_colons;
    has $.delimited_token_trees;
    has $.maybe_ident;
}

our class TyPath {
    has $.path_generic_args_without_colons;
}

our class TyPtr {
    has $.maybe_mut_or_const;
    has $.ty;
}

our class TyRptr {
    has $.ty;
    has $.maybe_mut;
    has $.lifetime;
}

our class TyTypeof {
    has $.expr;
}

our class TyVec {
    has $.ty;
}

our class TyPrim::G {

    proto rule ty-prim { * }

    rule ty-prim:sym<a> {
        {self.set-prec(IDENT)} <path-generic_args_without_colons>
    }

    rule ty-prim:sym<b> {
        {self.set-prec(IDENT)} <MOD-SEP> <path-generic_args_without_colons>
    }

    rule ty-prim:sym<c> {
        {self.set-prec(IDENT)} <SELF> <MOD-SEP> <path-generic_args_without_colons>
    }

    rule ty-prim:sym<d> {
        {self.set-prec(IDENT)} <path-generic_args_without_colons> '!' <maybe-ident> <delimited-token_trees>
    }

    rule ty-prim:sym<e> {
        {self.set-prec(IDENT)} <MOD-SEP> <path-generic_args_without_colons> '!' <maybe-ident> <delimited-token_trees>
    }

    rule ty-prim:sym<f> {
        <BOX> <ty>
    }

    rule ty-prim:sym<g> {
        '*' <maybe-mut_or_const> <ty>
    }

    rule ty-prim:sym<h> {
        '&' <ty>
    }

    rule ty-prim:sym<i> {
        '&' <MUT> <ty>
    }

    rule ty-prim:sym<j> {
        <ANDAND> <ty>
    }

    rule ty-prim:sym<k> {
        <ANDAND> <MUT> <ty>
    }

    rule ty-prim:sym<l> {
        '&' <lifetime> <maybe-mut> <ty>
    }

    rule ty-prim:sym<m> {
        <ANDAND> <lifetime> <maybe-mut> <ty>
    }

    rule ty-prim:sym<n> {
        '[' <ty> ']'
    }

    rule ty-prim:sym<o> {
        '[' <ty> ',' <DOTDOT> <expr> ']'
    }

    rule ty-prim:sym<p> {
        '[' <ty> ';' <expr> ']'
    }

    rule ty-prim:sym<q> {
        <TYPEOF> '(' <expr> ')'
    }

    rule ty-prim:sym<r> {
        <UNDERSCORE>
    }

    rule ty-prim:sym<s> {
        <ty-bare_fn>
    }

    rule ty-prim:sym<t> {
        <for-in_type>
    }
}

our class TyPrim::A {

    method ty-prim:sym<a>($/) {
        make TyPath.new(
            path-generic_args_without_colons =>  $<path-generic_args_without_colons>.made,
        )
    }

    method ty-prim:sym<b>($/) {
        make TyPath.new(
            path-generic_args_without_colons =>  $<path-generic_args_without_colons>.made,
        )
    }

    method ty-prim:sym<c>($/) {
        make TyPath.new(
            path-generic_args_without_colons =>  $<path-generic_args_without_colons>.made,
        )
    }

    method ty-prim:sym<d>($/) {
        make TyMacro.new(
            path-generic_args_without_colons =>  $<path-generic_args_without_colons>.made,
            maybe-ident                      =>  $<maybe-ident>.made,
            delimited-token_trees            =>  $<delimited-token_trees>.made,
        )
    }

    method ty-prim:sym<e>($/) {
        make TyMacro.new(
            path-generic_args_without_colons =>  $<path-generic_args_without_colons>.made,
            maybe-ident                      =>  $<maybe-ident>.made,
            delimited-token_trees            =>  $<delimited-token_trees>.made,
        )
    }

    method ty-prim:sym<f>($/) {
        make TyBox.new(
            ty =>  $<ty>.made,
        )
    }

    method ty-prim:sym<g>($/) {
        make TyPtr.new(
            maybe-mut_or_const =>  $<maybe-mut_or_const>.made,
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
        make $<ty-bare_fn>.made
    }

    method ty-prim:sym<t>($/) {
        make $<for-in_type>.made
    }
}

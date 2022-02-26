our class ExprAgain {
    has $.lifetime;
    has $.ident;
}

our class ExprAssignMul {
    has $.nonblock_expr;
    has $.expr;
    has $.expr_nostruct;
}

our class ExprAssignSub {
    has $.expr;
    has $.expr_nostruct;
    has $.nonblock_expr;
}

our class ExprBinary {
    has $.expr;
    has $.expr_nostruct;
    has $.nonblock_expr;
}

our class ExprBreak {
    has $.ident;
}

our class ExprCall {
    has $.block_expr;
    has $.block_expr_dot;
    has $.expr;
    has $.expr_nostruct;
    has $.maybe_exprs;
    has $.nonblock_expr;
    has $.path_generic_args_with_colons;
}

our class ExprLit {
    has $.lit;
}

our class Expr::Rules {

    proto rule expr { * }

    rule expr:sym<a>  { <lit> }
    rule expr:sym<b>  { {self.set-prec(IDENT)} <path-expr> }
    rule expr:sym<c>  { <SELF> }
    rule expr:sym<d>  { <macro-expr> }
    rule expr:sym<e>  { <path-expr> '{' <struct-expr_fields> '}' }
    rule expr:sym<f>  { <expr> '?' }
    rule expr:sym<g>  { <expr> '.' <path-generic_args_with_colons> }
    rule expr:sym<h>  { <expr> '.' <LIT-INTEGER> }
    rule expr:sym<i>  { <expr> '[' <maybe-expr> ']' }
    rule expr:sym<j>  { <expr> '(' <maybe-exprs> ')' }
    rule expr:sym<k>  { '(' <maybe-exprs> ')' }
    rule expr:sym<l>  { '[' <vec-expr> ']' }
    rule expr:sym<m>  { <CONTINUE> }
    rule expr:sym<n>  { <CONTINUE> <ident> }
    rule expr:sym<o>  { <RETURN> }
    rule expr:sym<p>  { <RETURN> <expr> }
    rule expr:sym<q>  { <BREAK> }
    rule expr:sym<r>  { <BREAK> <ident> }
    rule expr:sym<s>  { <YIELD> }
    rule expr:sym<t>  { <YIELD> <expr> }
    rule expr:sym<u>  { <expr> '=' <expr> }
    rule expr:sym<v>  { <expr> <SHLEQ> <expr> }
    rule expr:sym<w>  { <expr> <SHREQ> <expr> }
    rule expr:sym<x>  { <expr> <MINUSEQ> <expr> }
    rule expr:sym<y>  { <expr> <ANDEQ> <expr> }
    rule expr:sym<z>  { <expr> <OREQ> <expr> }
    rule expr:sym<aa> { <expr> <PLUSEQ> <expr> }
    rule expr:sym<ab> { <expr> <STAREQ> <expr> }
    rule expr:sym<ac> { <expr> <SLASHEQ> <expr> }
    rule expr:sym<ad> { <expr> <CARETEQ> <expr> }
    rule expr:sym<ae> { <expr> <PERCENTEQ> <expr> }
    rule expr:sym<af> { <expr> <OROR> <expr> }
    rule expr:sym<ag> { <expr> <ANDAND> <expr> }
    rule expr:sym<ah> { <expr> <EQEQ> <expr> }
    rule expr:sym<ai> { <expr> <NE> <expr> }
    rule expr:sym<aj> { <expr> '<' <expr> }
    rule expr:sym<ak> { <expr> '>' <expr> }
    rule expr:sym<al> { <expr> <LE> <expr> }
    rule expr:sym<am> { <expr> <GE> <expr> }
    rule expr:sym<an> { <expr> '|' <expr> }
    rule expr:sym<ao> { <expr> '^' <expr> }
    rule expr:sym<ap> { <expr> '&' <expr> }
    rule expr:sym<aq> { <expr> <SHL> <expr> }
    rule expr:sym<ar> { <expr> <SHR> <expr> }
    rule expr:sym<as> { <expr> '+' <expr> }
    rule expr:sym<at> { <expr> '-' <expr> }
    rule expr:sym<au> { <expr> '*' <expr> }
    rule expr:sym<av> { <expr> '/' <expr> }
    rule expr:sym<aw> { <expr> '%' <expr> }
    rule expr:sym<ax> { <expr> <DOTDOT> }
    rule expr:sym<ay> { <expr> <DOTDOT> <expr> }
    rule expr:sym<az> { <DOTDOT> <expr> }
    rule expr:sym<ba> { <DOTDOT> }
    rule expr:sym<bb> { <expr> <AS> <ty> }
    rule expr:sym<bc> { <expr> ':' <ty> }
    rule expr:sym<bd> { <BOX> <expr> }
    rule expr:sym<be> { <expr-qualified_path> }
    rule expr:sym<bf> { <block-expr> }
    rule expr:sym<bg> { <block> }
    rule expr:sym<bh> { <nonblock-prefix_expr> }
}

our class Expr::Actions {

    method expr:sym<a>($/) {
        make ExprLit.new(
            lit =>  $<lit>.made,
        )
    }

    method expr:sym<b>($/) {
        make ExprPath.new(
            path-expr =>  $<path-expr>.made,
        )
    }

    method expr:sym<c>($/) {
        make ExprPath.new(

        )
    }

    method expr:sym<d>($/) {
        make ExprMac.new(
            macro-expr =>  $<macro-expr>.made,
        )
    }

    method expr:sym<e>($/) {
        make ExprStruct.new(
            path-expr          =>  $<path-expr>.made,
            struct-expr_fields =>  $<struct-expr_fields>.made,
        )
    }

    method expr:sym<f>($/) {
        make ExprTry.new(
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<g>($/) {
        make ExprField.new(
            expr                          =>  $<expr>.made,
            path-generic_args_with_colons =>  $<path-generic_args_with_colons>.made,
        )
    }

    method expr:sym<h>($/) {
        make ExprTupleIndex.new(
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<i>($/) {
        make ExprIndex.new(
            expr       =>  $<expr>.made,
            maybe-expr =>  $<maybe-expr>.made,
        )
    }

    method expr:sym<j>($/) {
        make ExprCall.new(
            expr        =>  $<expr>.made,
            maybe-exprs =>  $<maybe-exprs>.made,
        )
    }

    method expr:sym<k>($/) {
        make ExprParen.new(
            maybe-exprs =>  $<maybe-exprs>.made,
        )
    }

    method expr:sym<l>($/) {
        make ExprVec.new(
            vec-expr =>  $<vec-expr>.made,
        )
    }

    method expr:sym<m>($/) {
        make ExprAgain.new(

        )
    }

    method expr:sym<n>($/) {
        make ExprAgain.new(
            ident =>  $<ident>.made,
        )
    }

    method expr:sym<o>($/) {
        make ExprRet.new(

        )
    }

    method expr:sym<p>($/) {
        make ExprRet.new(
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<q>($/) {
        make ExprBreak.new(

        )
    }

    method expr:sym<r>($/) {
        make ExprBreak.new(
            ident =>  $<ident>.made,
        )
    }

    method expr:sym<s>($/) {
        make ExprYield.new(

        )
    }

    method expr:sym<t>($/) {
        make ExprYield.new(
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<u>($/) {
        make ExprAssign.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<v>($/) {
        make ExprAssignShl.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<w>($/) {
        make ExprAssignShr.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<x>($/) {
        make ExprAssignSub.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<y>($/) {
        make ExprAssignBitAnd.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<z>($/) {
        make ExprAssignBitOr.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<aa>($/) {
        make ExprAssignAdd.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<ab>($/) {
        make ExprAssignMul.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<ac>($/) {
        make ExprAssignDiv.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<ad>($/) {
        make ExprAssignBitXor.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<ae>($/) {
        make ExprAssignRem.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<af>($/) {
        make ExprBinary.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<ag>($/) {
        make ExprBinary.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<ah>($/) {
        make ExprBinary.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<ai>($/) {
        make ExprBinary.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<aj>($/) {
        make ExprBinary.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<ak>($/) {
        make ExprBinary.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<al>($/) {
        make ExprBinary.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<am>($/) {
        make ExprBinary.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<an>($/) {
        make ExprBinary.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<ao>($/) {
        make ExprBinary.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<ap>($/) {
        make ExprBinary.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<aq>($/) {
        make ExprBinary.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<ar>($/) {
        make ExprBinary.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<as>($/) {
        make ExprBinary.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<at>($/) {
        make ExprBinary.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<au>($/) {
        make ExprBinary.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<av>($/) {
        make ExprBinary.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<aw>($/) {
        make ExprBinary.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<ax>($/) {
        make ExprRange.new(
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<ay>($/) {
        make ExprRange.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<az>($/) {
        make ExprRange.new(
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<ba>($/) {
        make ExprRange.new(

        )
    }

    method expr:sym<bb>($/) {
        make ExprCast.new(
            expr =>  $<expr>.made,
            ty   =>  $<ty>.made,
        )
    }

    method expr:sym<bc>($/) {
        make ExprTypeAscr.new(
            expr =>  $<expr>.made,
            ty   =>  $<ty>.made,
        )
    }

    method expr:sym<bd>($/) {
        make ExprBox.new(
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<be>($/) {
        make $<expr-qualified_path>.made
    }

    method expr:sym<bf>($/) {
        make $<block-expr>.made
    }

    method expr:sym<bg>($/) {
        make $<block>.made
    }

    method expr:sym<bh>($/) {
        make $<nonblock-prefix_expr>.made
    }
}

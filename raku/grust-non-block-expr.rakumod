
#-------------------------------------

our class ExprAssign {
    has $.expr;
    has $.nonblock_expr;
    has $.expr_nostruct;
}

our class ExprAssignAdd {
    has $.expr;
    has $.expr_nostruct;
    has $.nonblock_expr;
}

our class ExprAssignBitAnd {
    has $.expr;
    has $.expr_nostruct;
    has $.nonblock_expr;
}

our class ExprAssignBitOr {
    has $.nonblock_expr;
    has $.expr;
    has $.expr_nostruct;
}

our class ExprAssignBitXor {
    has $.expr;
    has $.expr_nostruct;
    has $.nonblock_expr;
}

our class ExprAssignDiv {
    has $.expr;
    has $.nonblock_expr;
    has $.expr_nostruct;
}

our class ExprAssignRem {
    has $.expr;
    has $.expr_nostruct;
    has $.nonblock_expr;
}

our class ExprAssignShl {
    has $.nonblock_expr;
    has $.expr;
    has $.expr_nostruct;
}

our class ExprBox {
    has $.expr;
}

our class ExprBreak {
    has $.lifetime;
}

our class ExprField {
    has $.block_expr;
    has $.block_expr_dot;
    has $.expr;
    has $.expr_nostruct;
    has $.nonblock_expr;
    has $.path_generic_args_with_colons;
}

our class ExprIndex {
    has $.block_expr;
    has $.block_expr_dot;
    has $.expr;
    has $.expr_nostruct;
    has $.maybe_expr;
    has $.nonblock_expr;
    has $.path_generic_args_with_colons;
}

our class ExprMac {
    has $.macro_expr;
}

our class ExprParen {
    has $.maybe_exprs;
}

our class ExprPath {
    has $.path_expr;
}

our class ExprRange {
    has $.expr;
    has $.expr_nostruct;
    has $.nonblock_expr;
}

our class ExprRet {
    has $.expr;
}

our class ExprStruct {
    has $.path_expr;
    has $.struct_expr_fields;
}

our class ExprTry {
    has $.expr;
    has $.expr_nostruct;
    has $.nonblock_expr;
}

our class ExprTupleIndex {
    has $.block_expr;
    has $.block_expr_dot;
    has $.expr;
    has $.expr_nostruct;
    has $.nonblock_expr;
}

our class ExprTypeAscr {
    has $.expr;
    has $.expr_nostruct;
    has $.nonblock_expr;
    has $.ty;
}

our class ExprVec {
    has $.vec_expr;
}

our class ExprYield {
    has $.expr;
}

our class NonBlockExpr::Rules {

    proto rule nonblock-expr { * }

    rule nonblock-expr:sym<a> {
        <lit>
    }

    rule nonblock-expr:sym<b> {
        {self.set-prec(IDENT)} <path-expr>
    }

    rule nonblock-expr:sym<c> {
        <SELF>
    }

    rule nonblock-expr:sym<d> {
        <macro-expr>
    }

    rule nonblock-expr:sym<e> {
        <path-expr> '{' <struct-expr_fields> '}'
    }

    rule nonblock-expr:sym<f> {
        <nonblock-expr> '?'
    }

    rule nonblock-expr:sym<g> {
        <nonblock-expr> '.' <path-generic_args_with_colons>
    }

    rule nonblock-expr:sym<h> {
        <nonblock-expr> '.' <LIT-INTEGER>
    }

    rule nonblock-expr:sym<i> {
        <nonblock-expr> '[' <maybe-expr> ']'
    }

    rule nonblock-expr:sym<j> {
        <nonblock-expr> '(' <maybe-exprs> ')'
    }

    rule nonblock-expr:sym<k> {
        '[' <vec-expr> ']'
    }

    rule nonblock-expr:sym<l> {
        '(' <maybe-exprs> ')'
    }

    rule nonblock-expr:sym<m> {
        <CONTINUE>
    }

    rule nonblock-expr:sym<n> {
        <CONTINUE> <lifetime>
    }

    rule nonblock-expr:sym<o> {
        <RETURN>
    }

    rule nonblock-expr:sym<p> {
        <RETURN> <expr>
    }

    rule nonblock-expr:sym<q> {
        <BREAK>
    }

    rule nonblock-expr:sym<r> {
        <BREAK> <lifetime>
    }

    rule nonblock-expr:sym<s> {
        <YIELD>
    }

    rule nonblock-expr:sym<t> {
        <YIELD> <expr>
    }

    rule nonblock-expr:sym<u> {
        <nonblock-expr> '=' <expr>
    }

    rule nonblock-expr:sym<v> {
        <nonblock-expr> <SHLEQ> <expr>
    }

    rule nonblock-expr:sym<w> {
        <nonblock-expr> <SHREQ> <expr>
    }

    rule nonblock-expr:sym<x> {
        <nonblock-expr> <MINUSEQ> <expr>
    }

    rule nonblock-expr:sym<y> {
        <nonblock-expr> <ANDEQ> <expr>
    }

    rule nonblock-expr:sym<z> {
        <nonblock-expr> <OREQ> <expr>
    }

    rule nonblock-expr:sym<aa> {
        <nonblock-expr> <PLUSEQ> <expr>
    }

    rule nonblock-expr:sym<ab> {
        <nonblock-expr> <STAREQ> <expr>
    }

    rule nonblock-expr:sym<ac> {
        <nonblock-expr> <SLASHEQ> <expr>
    }

    rule nonblock-expr:sym<ad> {
        <nonblock-expr> <CARETEQ> <expr>
    }

    rule nonblock-expr:sym<ae> {
        <nonblock-expr> <PERCENTEQ> <expr>
    }

    rule nonblock-expr:sym<af> {
        <nonblock-expr> <OROR> <expr>
    }

    rule nonblock-expr:sym<ag> {
        <nonblock-expr> <ANDAND> <expr>
    }

    rule nonblock-expr:sym<ah> {
        <nonblock-expr> <EQEQ> <expr>
    }

    rule nonblock-expr:sym<ai> {
        <nonblock-expr> <NE> <expr>
    }

    rule nonblock-expr:sym<aj> {
        <nonblock-expr> '<' <expr>
    }

    rule nonblock-expr:sym<ak> {
        <nonblock-expr> '>' <expr>
    }

    rule nonblock-expr:sym<al> {
        <nonblock-expr> <LE> <expr>
    }

    rule nonblock-expr:sym<am> {
        <nonblock-expr> <GE> <expr>
    }

    rule nonblock-expr:sym<an> {
        <nonblock-expr> '|' <expr>
    }

    rule nonblock-expr:sym<ao> {
        <nonblock-expr> '^' <expr>
    }

    rule nonblock-expr:sym<ap> {
        <nonblock-expr> '&' <expr>
    }

    rule nonblock-expr:sym<aq> {
        <nonblock-expr> <SHL> <expr>
    }

    rule nonblock-expr:sym<ar> {
        <nonblock-expr> <SHR> <expr>
    }

    rule nonblock-expr:sym<as> {
        <nonblock-expr> '+' <expr>
    }

    rule nonblock-expr:sym<at> {
        <nonblock-expr> '-' <expr>
    }

    rule nonblock-expr:sym<au> {
        <nonblock-expr> '*' <expr>
    }

    rule nonblock-expr:sym<av> {
        <nonblock-expr> '/' <expr>
    }

    rule nonblock-expr:sym<aw> {
        <nonblock-expr> '%' <expr>
    }

    rule nonblock-expr:sym<ax> {
        <nonblock-expr> <DOTDOT>
    }

    rule nonblock-expr:sym<ay> {
        <nonblock-expr> <DOTDOT> <expr>
    }

    rule nonblock-expr:sym<az> {
        <DOTDOT> <expr>
    }

    rule nonblock-expr:sym<ba> {
        <DOTDOT>
    }

    rule nonblock-expr:sym<bb> {
        <nonblock-expr> <AS> <ty>
    }

    rule nonblock-expr:sym<bc> {
        <nonblock-expr> ':' <ty>
    }

    rule nonblock-expr:sym<bd> {
        <BOX> <expr>
    }

    rule nonblock-expr:sym<be> {
        <expr-qualified_path>
    }

    rule nonblock-expr:sym<bf> {
        <nonblock-prefix_expr>
    }
}

our class NonBlockExpr::Actions {

    method nonblock-expr:sym<a>($/) {
        make ExprLit.new(
            lit =>  $<lit>.made,
        )
    }

    method nonblock-expr:sym<b>($/) {
        make ExprPath.new(
            path-expr =>  $<path-expr>.made,
        )
    }

    method nonblock-expr:sym<c>($/) {
        make ExprPath.new(

        )
    }

    method nonblock-expr:sym<d>($/) {
        make ExprMac.new(
            macro-expr =>  $<macro-expr>.made,
        )
    }

    method nonblock-expr:sym<e>($/) {
        make ExprStruct.new(
            path-expr          =>  $<path-expr>.made,
            struct-expr_fields =>  $<struct-expr_fields>.made,
        )
    }

    method nonblock-expr:sym<f>($/) {
        make ExprTry.new(
            nonblock-expr =>  $<nonblock-expr>.made,
        )
    }

    method nonblock-expr:sym<g>($/) {
        make ExprField.new(
            nonblock-expr                 =>  $<nonblock-expr>.made,
            path-generic_args_with_colons =>  $<path-generic_args_with_colons>.made,
        )
    }

    method nonblock-expr:sym<h>($/) {
        make ExprTupleIndex.new(
            nonblock-expr =>  $<nonblock-expr>.made,
        )
    }

    method nonblock-expr:sym<i>($/) {
        make ExprIndex.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            maybe-expr    =>  $<maybe-expr>.made,
        )
    }

    method nonblock-expr:sym<j>($/) {
        make ExprCall.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            maybe-exprs   =>  $<maybe-exprs>.made,
        )
    }

    method nonblock-expr:sym<k>($/) {
        make ExprVec.new(
            vec-expr =>  $<vec-expr>.made,
        )
    }

    method nonblock-expr:sym<l>($/) {
        make ExprParen.new(
            maybe-exprs =>  $<maybe-exprs>.made,
        )
    }

    method nonblock-expr:sym<m>($/) {
        make ExprAgain.new(

        )
    }

    method nonblock-expr:sym<n>($/) {
        make ExprAgain.new(
            lifetime =>  $<lifetime>.made,
        )
    }

    method nonblock-expr:sym<o>($/) {
        make ExprRet.new(

        )
    }

    method nonblock-expr:sym<p>($/) {
        make ExprRet.new(
            expr =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<q>($/) {
        make ExprBreak.new(

        )
    }

    method nonblock-expr:sym<r>($/) {
        make ExprBreak.new(
            lifetime =>  $<lifetime>.made,
        )
    }

    method nonblock-expr:sym<s>($/) {
        make ExprYield.new(

        )
    }

    method nonblock-expr:sym<t>($/) {
        make ExprYield.new(
            expr =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<u>($/) {
        make ExprAssign.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<v>($/) {
        make ExprAssignShl.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<w>($/) {
        make ExprAssignShr.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<x>($/) {
        make ExprAssignSub.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<y>($/) {
        make ExprAssignBitAnd.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<z>($/) {
        make ExprAssignBitOr.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<aa>($/) {
        make ExprAssignAdd.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<ab>($/) {
        make ExprAssignMul.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<ac>($/) {
        make ExprAssignDiv.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<ad>($/) {
        make ExprAssignBitXor.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<ae>($/) {
        make ExprAssignRem.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<af>($/) {
        make ExprBinary.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<ag>($/) {
        make ExprBinary.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<ah>($/) {
        make ExprBinary.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<ai>($/) {
        make ExprBinary.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<aj>($/) {
        make ExprBinary.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<ak>($/) {
        make ExprBinary.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<al>($/) {
        make ExprBinary.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<am>($/) {
        make ExprBinary.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<an>($/) {
        make ExprBinary.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<ao>($/) {
        make ExprBinary.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<ap>($/) {
        make ExprBinary.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<aq>($/) {
        make ExprBinary.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<ar>($/) {
        make ExprBinary.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<as>($/) {
        make ExprBinary.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<at>($/) {
        make ExprBinary.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<au>($/) {
        make ExprBinary.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<av>($/) {
        make ExprBinary.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<aw>($/) {
        make ExprBinary.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<ax>($/) {
        make ExprRange.new(
            nonblock-expr =>  $<nonblock-expr>.made,
        )
    }

    method nonblock-expr:sym<ay>($/) {
        make ExprRange.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<az>($/) {
        make ExprRange.new(
            expr =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<ba>($/) {
        make ExprRange.new(

        )
    }

    method nonblock-expr:sym<bb>($/) {
        make ExprCast.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            ty            =>  $<ty>.made,
        )
    }

    method nonblock-expr:sym<bc>($/) {
        make ExprTypeAscr.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            ty            =>  $<ty>.made,
        )
    }

    method nonblock-expr:sym<bd>($/) {
        make ExprBox.new(
            expr =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<be>($/) {
        make $<expr-qualified_path>.made
    }

    method nonblock-expr:sym<bf>($/) {
        make $<nonblock-prefix_expr>.made
    }
}

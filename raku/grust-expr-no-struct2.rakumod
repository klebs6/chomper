

our class ExprAgain {
    has $.ident;
}

our class ExprAssign {
    has $.expr_nostruct;
}

our class ExprAssignAdd {
    has $.expr_nostruct;
}

our class ExprAssignBitAnd {
    has $.expr_nostruct;
}

our class ExprAssignBitOr {
    has $.expr_nostruct;
}

our class ExprAssignBitXor {
    has $.expr_nostruct;
}

our class ExprAssignDiv {
    has $.expr_nostruct;
}

our class ExprAssignMul {
    has $.expr_nostruct;
}

our class ExprAssignRem {
    has $.expr_nostruct;
}

our class ExprAssignShl {
    has $.expr_nostruct;
}

our class ExprAssignShr {
    has $.expr_nostruct;
}

our class ExprAssignSub {
    has $.expr_nostruct;
}

our class ExprBinary {
    has $.expr_nostruct;
}

our class ExprBox {
    has $.expr;
}

our class ExprBreak {
    has $.ident;
}

our class ExprCall {
    has $.maybe_exprs;
    has $.expr_nostruct;
}

our class ExprCast {
    has $.expr_nostruct;
    has $.ty;
}

our class ExprField {
    has $.path_generic_args_with_colons;
    has $.expr_nostruct;
}

our class ExprIndex {
    has $.expr_nostruct;
    has $.maybe_expr;
}

our class ExprLit {
    has $.lit;
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
    has $.expr_nostruct;
}

our class ExprRet {
    has $.expr;
}

our class ExprTry {
    has $.expr_nostruct;
}

our class ExprTupleIndex {
    has $.expr_nostruct;
}

our class ExprTypeAscr {
    has $.expr_nostruct;
    has $.ty;
}

our class ExprVec {
    has $.vec_expr;
}

our class ExprYield {
    has $.expr;
}

our class ExprNoStruct::G {

}

our class ExprNoStruct::A {

    method expr-nostruct:sym<a>($/) {
        make ExprLit.new(
            lit =>  $<lit>.made,
        )
    }

    method expr-nostruct:sym<b>($/) {
        make ExprPath.new(
            path-expr =>  $<path-expr>.made,
        )
    }

    method expr-nostruct:sym<c>($/) {
        make ExprPath.new(

        )
    }

    method expr-nostruct:sym<d>($/) {
        make ExprMac.new(
            macro-expr =>  $<macro-expr>.made,
        )
    }

    method expr-nostruct:sym<e>($/) {
        make ExprTry.new(
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<f>($/) {
        make ExprField.new(
            expr-nostruct                 =>  $<expr-nostruct>.made,
            path-generic_args_with_colons =>  $<path-generic_args_with_colons>.made,
        )
    }

    method expr-nostruct:sym<g>($/) {
        make ExprTupleIndex.new(
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<h>($/) {
        make ExprIndex.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            maybe-expr    =>  $<maybe-expr>.made,
        )
    }

    method expr-nostruct:sym<i>($/) {
        make ExprCall.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            maybe-exprs   =>  $<maybe-exprs>.made,
        )
    }

    method expr-nostruct:sym<j>($/) {
        make ExprVec.new(
            vec-expr =>  $<vec-expr>.made,
        )
    }

    method expr-nostruct:sym<k>($/) {
        make ExprParen.new(
            maybe-exprs =>  $<maybe-exprs>.made,
        )
    }

    method expr-nostruct:sym<l>($/) {
        make ExprAgain.new(

        )
    }

    method expr-nostruct:sym<m>($/) {
        make ExprAgain.new(
            ident =>  $<ident>.made,
        )
    }

    method expr-nostruct:sym<n>($/) {
        make ExprRet.new(

        )
    }

    method expr-nostruct:sym<o>($/) {
        make ExprRet.new(
            expr =>  $<expr>.made,
        )
    }

    method expr-nostruct:sym<p>($/) {
        make ExprBreak.new(

        )
    }

    method expr-nostruct:sym<q>($/) {
        make ExprBreak.new(
            ident =>  $<ident>.made,
        )
    }

    method expr-nostruct:sym<r>($/) {
        make ExprYield.new(

        )
    }

    method expr-nostruct:sym<s>($/) {
        make ExprYield.new(
            expr =>  $<expr>.made,
        )
    }

    method expr-nostruct:sym<t>($/) {
        make ExprAssign.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<u>($/) {
        make ExprAssignShl.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<v>($/) {
        make ExprAssignShr.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<w>($/) {
        make ExprAssignSub.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<x>($/) {
        make ExprAssignBitAnd.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<y>($/) {
        make ExprAssignBitOr.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<z>($/) {
        make ExprAssignAdd.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<aa>($/) {
        make ExprAssignMul.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<ab>($/) {
        make ExprAssignDiv.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<ac>($/) {
        make ExprAssignBitXor.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<ad>($/) {
        make ExprAssignRem.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<ae>($/) {
        make ExprBinary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<af>($/) {
        make ExprBinary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<ag>($/) {
        make ExprBinary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<ah>($/) {
        make ExprBinary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<ai>($/) {
        make ExprBinary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<aj>($/) {
        make ExprBinary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<ak>($/) {
        make ExprBinary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<al>($/) {
        make ExprBinary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<am>($/) {
        make ExprBinary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<an>($/) {
        make ExprBinary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<ao>($/) {
        make ExprBinary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<ap>($/) {
        make ExprBinary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<aq>($/) {
        make ExprBinary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<ar>($/) {
        make ExprBinary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<as>($/) {
        make ExprBinary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<at>($/) {
        make ExprBinary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<au>($/) {
        make ExprBinary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<av>($/) {
        make ExprBinary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<aw>($/) {
        make ExprRange.new(
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<ax>($/) {
        make ExprRange.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<ay>($/) {
        make ExprRange.new(
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<az>($/) {
        make ExprRange.new(

        )
    }

    method expr-nostruct:sym<ba>($/) {
        make ExprCast.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            ty            =>  $<ty>.made,
        )
    }

    method expr-nostruct:sym<bb>($/) {
        make ExprTypeAscr.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            ty            =>  $<ty>.made,
        )
    }

    method expr-nostruct:sym<bc>($/) {
        make ExprBox.new(
            expr =>  $<expr>.made,
        )
    }

    method expr-nostruct:sym<bd>($/) {
        make $<expr-qualified_path>.made
    }

    method expr-nostruct:sym<be>($/) {
        make $<block-expr>.made
    }

    method expr-nostruct:sym<bf>($/) {
        make $<block>.made
    }

    method expr-nostruct:sym<bg>($/) {
        make $<nonblock-prefix_expr_nostruct>.made
    }
}


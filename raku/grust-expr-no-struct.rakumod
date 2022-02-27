use grust-model;

#-------------------------------------

our role ExprNoStruct::Rules {

    proto rule expr-nostruct { * }

    rule expr-nostruct:sym<a>  { <lit> }

    rule expr-nostruct:sym<b>  { 
        #{ self.set-prec(IDENT) } 
        <path-expr> 
    }

    rule expr-nostruct:sym<c>  { <SELF> }
    rule expr-nostruct:sym<d>  { <macro-expr> }
    rule expr-nostruct:sym<e>  { <expr-nostruct> '?' }
    rule expr-nostruct:sym<f>  { <expr-nostruct> '.' <path-generic_args_with_colons> }
    rule expr-nostruct:sym<g>  { <expr-nostruct> '.' <LIT-INTEGER> }
    rule expr-nostruct:sym<h>  { <expr-nostruct> '[' <maybe-expr> ']' }
    rule expr-nostruct:sym<i>  { <expr-nostruct> '(' <maybe-exprs> ')' }
    rule expr-nostruct:sym<j>  { '[' <vec-expr> ']' }
    rule expr-nostruct:sym<k>  { '(' <maybe-exprs> ')' }
    rule expr-nostruct:sym<l>  { <CONTINUE> }
    rule expr-nostruct:sym<m>  { <CONTINUE> <ident> }
    rule expr-nostruct:sym<n>  { <RETURN> }
    rule expr-nostruct:sym<o>  { <RETURN> <expr> }
    rule expr-nostruct:sym<p>  { <BREAK> }
    rule expr-nostruct:sym<q>  { <BREAK> <ident> }
    rule expr-nostruct:sym<r>  { <YIELD> }
    rule expr-nostruct:sym<s>  { <YIELD> <expr> }
    rule expr-nostruct:sym<t>  { <expr-nostruct> '='           <expr-nostruct> }
    rule expr-nostruct:sym<u>  { <expr-nostruct> <SHLEQ>       <expr-nostruct> }
    rule expr-nostruct:sym<v>  { <expr-nostruct> <SHREQ>       <expr-nostruct> }
    rule expr-nostruct:sym<w>  { <expr-nostruct> <MINUSEQ>     <expr-nostruct> }
    rule expr-nostruct:sym<x>  { <expr-nostruct> <ANDEQ>       <expr-nostruct> }
    rule expr-nostruct:sym<y>  { <expr-nostruct> <OREQ>        <expr-nostruct> }
    rule expr-nostruct:sym<z>  { <expr-nostruct> <PLUSEQ>      <expr-nostruct> }
    rule expr-nostruct:sym<aa> { <expr-nostruct> <STAREQ>      <expr-nostruct> }
    rule expr-nostruct:sym<ab> { <expr-nostruct> <SLASHEQ>     <expr-nostruct> }
    rule expr-nostruct:sym<ac> { <expr-nostruct> <CARETEQ>     <expr-nostruct> }
    rule expr-nostruct:sym<ad> { <expr-nostruct> <PERCENTEQ>   <expr-nostruct> }
    rule expr-nostruct:sym<ae> { <expr-nostruct> <OROR>        <expr-nostruct> }
    rule expr-nostruct:sym<af> { <expr-nostruct> <ANDAND>      <expr-nostruct> }
    rule expr-nostruct:sym<ag> { <expr-nostruct> <EQEQ>        <expr-nostruct> }
    rule expr-nostruct:sym<ah> { <expr-nostruct> <NE>          <expr-nostruct> }
    rule expr-nostruct:sym<ai> { <expr-nostruct> '<'           <expr-nostruct> }
    rule expr-nostruct:sym<aj> { <expr-nostruct> '>'           <expr-nostruct> }
    rule expr-nostruct:sym<ak> { <expr-nostruct> <LE>          <expr-nostruct> }
    rule expr-nostruct:sym<al> { <expr-nostruct> <GE>          <expr-nostruct> }
    rule expr-nostruct:sym<am> { <expr-nostruct> '|'           <expr-nostruct> }
    rule expr-nostruct:sym<an> { <expr-nostruct> '^'           <expr-nostruct> }
    rule expr-nostruct:sym<ao> { <expr-nostruct> '&'           <expr-nostruct> }
    rule expr-nostruct:sym<ap> { <expr-nostruct> <SHL>         <expr-nostruct> }
    rule expr-nostruct:sym<aq> { <expr-nostruct> <SHR>         <expr-nostruct> }
    rule expr-nostruct:sym<ar> { <expr-nostruct> '+'           <expr-nostruct> }
    rule expr-nostruct:sym<as> { <expr-nostruct> '-'           <expr-nostruct> }
    rule expr-nostruct:sym<at> { <expr-nostruct> '*'           <expr-nostruct> }
    rule expr-nostruct:sym<au> { <expr-nostruct> '/'           <expr-nostruct> }
    rule expr-nostruct:sym<av> { <expr-nostruct> '%'           <expr-nostruct> }

    rule expr-nostruct:sym<aw> { 
        <expr-nostruct> 
        <DOTDOT>      
        #{ self.set-prec(RANGE) } 
    }

    rule expr-nostruct:sym<ax> { <expr-nostruct> <DOTDOT> <expr-nostruct> }
    rule expr-nostruct:sym<ay> { <DOTDOT> <expr-nostruct> }
    rule expr-nostruct:sym<az> { <DOTDOT> }
    rule expr-nostruct:sym<ba> { <expr-nostruct> <AS> <ty> }
    rule expr-nostruct:sym<bb> { <expr-nostruct> ':' <ty> }
    rule expr-nostruct:sym<bc> { <BOX> <expr> }
    rule expr-nostruct:sym<bd> { <expr-qualified_path> }
    rule expr-nostruct:sym<be> { <block-expr> }
    rule expr-nostruct:sym<bf> { <block> }
    rule expr-nostruct:sym<bg> { <nonblock-prefix_expr_nostruct> }
}

our role ExprNoStruct::Actions {

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

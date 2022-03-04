use grust-model;

#-------------------------------------

our role ExprNoStruct::Rules {

    rule expr-nostruct { 
        <expr-nostruct-base> 
        <expr-nostruct-tail>* 
    }

    #-------------------------
    proto rule expr-nostruct-base { * }

    rule expr-nostruct-base:sym<lit>  { <lit> }

    rule expr-nostruct-base:sym<self>                          { <kw-self> }
    rule expr-nostruct-base:sym<macro-expr>                    { <macro-expr> }
    rule expr-nostruct-base:sym<vec-expr>                      { '[' <vec-expr> ']' }
    rule expr-nostruct-base:sym<paren-expr>                    { '(' <maybe-exprs> ')' }
    rule expr-nostruct-base:sym<continue-ident>                { <kw-continue> <ident> }
    rule expr-nostruct-base:sym<continue>                      { <kw-continue> }
    rule expr-nostruct-base:sym<return-expr>                   { <kw-return> <expr> }
    rule expr-nostruct-base:sym<return>                        { <kw-return> }
    rule expr-nostruct-base:sym<break-ident>                   { <kw-break> <ident> }
    rule expr-nostruct-base:sym<break>                         { <kw-break> }
    rule expr-nostruct-base:sym<yield-expr>                    { <kw-yield> <expr> }
    rule expr-nostruct-base:sym<yield>                         { <kw-yield> }
    rule expr-nostruct-base:sym<dotdot-expr-nostruct>          { <tok-dotdot> <expr-nostruct> }
    rule expr-nostruct-base:sym<dotdot>                        { <tok-dotdot> }
    rule expr-nostruct-base:sym<box-expr>                      { <kw-box> <expr> }
    rule expr-nostruct-base:sym<expr-qualified-path>           { <expr-qualified-path> }
    rule expr-nostruct-base:sym<block-expr>                    { <block-expr> }
    rule expr-nostruct-base:sym<block>                         { <block> }
    rule expr-nostruct-base:sym<nonblock-prefix-expr-nostruct> { <nonblock-prefix-expr-nostruct> }
    rule expr-nostruct-base:sym<path-expr>                     { <path-expr> }

    #-------------------------
    proto rule expr-nostruct-tail { * }

    rule expr-nostruct-tail:sym<qmark>             { '?' }
    rule expr-nostruct-tail:sym<dot-path>          { '.' <path-generic-args-with-colons> }
    rule expr-nostruct-tail:sym<dot-lit-int>       { '.' <lit-int> }
    rule expr-nostruct-tail:sym<brack-expr>        { '[' <maybe-expr> ']' }
    rule expr-nostruct-tail:sym<paren-expr>        { '(' <maybe-exprs> ')' }
    rule expr-nostruct-tail:sym<eq-expr>           { '=' <expr-nostruct> }
    rule expr-nostruct-tail:sym<shleq-expr>        { <tok-shleq>       <expr-nostruct> }
    rule expr-nostruct-tail:sym<shreq-expr>        { <tok-shreq>       <expr-nostruct> }
    rule expr-nostruct-tail:sym<minuseq-expr>      { <tok-minuseq>     <expr-nostruct> }
    rule expr-nostruct-tail:sym<andeq-expr>        { <tok-andeq>       <expr-nostruct> }
    rule expr-nostruct-tail:sym<oreq-expr>         { <tok-oreq>        <expr-nostruct> }
    rule expr-nostruct-tail:sym<pluseq-expr>       { <tok-pluseq>      <expr-nostruct> }
    rule expr-nostruct-tail:sym<stareq-expr>       { <tok-stareq>      <expr-nostruct> }
    rule expr-nostruct-tail:sym<slasheq-expr>      { <tok-slasheq>     <expr-nostruct> }
    rule expr-nostruct-tail:sym<careteq-expr>      { <tok-careteq>     <expr-nostruct> }
    rule expr-nostruct-tail:sym<percenteq-expr>    { <tok-percenteq>   <expr-nostruct> }
    rule expr-nostruct-tail:sym<oror-expr>         { <tok-oror>        <expr-nostruct> }
    rule expr-nostruct-tail:sym<andand-expr>       { <tok-andand>      <expr-nostruct> }
    rule expr-nostruct-tail:sym<eqeq-expr>         { <tok-eqeq>        <expr-nostruct> }
    rule expr-nostruct-tail:sym<ne-expr>           { <tok-ne>          <expr-nostruct> }
    rule expr-nostruct-tail:sym<lt-expr>           { '<'           <expr-nostruct> }
    rule expr-nostruct-tail:sym<gt-expr>           { '>'           <expr-nostruct> }
    rule expr-nostruct-tail:sym<le-expr>           { <tok-le>          <expr-nostruct> }
    rule expr-nostruct-tail:sym<ge-expr>           { <tok-ge>          <expr-nostruct> }
    rule expr-nostruct-tail:sym<pipe-expr>         { '|'           <expr-nostruct> }
    rule expr-nostruct-tail:sym<caret-expr>        { '^'           <expr-nostruct> }
    rule expr-nostruct-tail:sym<amp-expr>          { '&'           <expr-nostruct> }
    rule expr-nostruct-tail:sym<shl-expr>          { <tok-shl>         <expr-nostruct> }
    rule expr-nostruct-tail:sym<shr-expr>          { <tok-shr>         <expr-nostruct> }
    rule expr-nostruct-tail:sym<plus-expr>         { '+'           <expr-nostruct> }
    rule expr-nostruct-tail:sym<minus-expr>        { '-'           <expr-nostruct> }
    rule expr-nostruct-tail:sym<star-expr>         { '*'           <expr-nostruct> }
    rule expr-nostruct-tail:sym<slash-expr>        { '/'           <expr-nostruct> }
    rule expr-nostruct-tail:sym<mod-expr>          { '%'           <expr-nostruct> }
    rule expr-nostruct-tail:sym<dotdot-nostruct>   { <tok-dotdot>      <expr-nostruct> }

    rule expr-nostruct-tail:sym<dotdot> { 
        <tok-dotdot>      
        #{ self.set-prec(RANGE) } 
    }

    rule expr-nostruct-tail:sym<as-try>    { <kw-as> <ty> }
    rule expr-nostruct-tail:sym<colon-try> { ':' <ty> }
}

our role ExprNoStruct::Actions {

    method expr-nostruct($/) {
        make ExprNoStruct.new(
            base => $<expr-nostruct-base>.made,
            tail => $<expr-nostruct-tail>>>.made,
        )
    }

    method expr-nostruct-base:sym<lit>($/) {
        make ExprLit.new(
            lit =>  $<lit>.made,
        )
    }

    method expr-nostruct-base:sym<path-expr>($/) {
        make ExprPath.new(
            path-expr =>  $<path-expr>.made,
        )
    }

    method expr-nostruct-base:sym<self>($/) {
        make ExprPath.new(

        )
    }

    method expr-nostruct-base:sym<macro-expr>($/) {
        make ExprMac.new(
            macro-expr =>  $<macro-expr>.made,
        )
    }

    method expr-nostruct-tail:sym<qmark>($/) {
        make ExprTry.new
    }

    method expr-nostruct-tail:sym<dot-path>($/) {
        make ExprField.new(
            path-generic-args-with-colons =>  $<path-generic-args-with-colons>.made,
        )
    }

    method expr-nostruct-tail:sym<dot-lit-int>($/) {
        make ExprTupleIndex.new(
            lit-int =>  $<lit-int>.made,
        )
    }

    method expr-nostruct-tail:sym<brack-expr>($/) {
        make ExprIndex.new(
            maybe-expr    =>  $<maybe-expr>.made,
        )
    }

    method expr-nostruct-base:sym<paren-expr>($/) {
        make ExprCall.new(
            maybe-exprs   =>  $<maybe-exprs>.made,
        )
    }

    method expr-nostruct-base:sym<vec-expr>($/) {
        make ExprVec.new(
            vec-expr =>  $<vec-expr>.made,
        )
    }

    method expr-nostruct-tail:sym<paren-expr>($/) {
        make ExprParen.new(
            maybe-exprs =>  $<maybe-exprs>.made,
        )
    }

    method expr-nostruct-base:sym<continue>($/) {
        make ExprAgain.new(

        )
    }

    method expr-nostruct-base:sym<continue-ident>($/) {
        make ExprAgain.new(
            ident =>  $<ident>.made,
        )
    }

    method expr-nostruct-base:sym<return>($/) {
        make ExprRet.new(

        )
    }

    method expr-nostruct-base:sym<return-expr>($/) {
        make ExprRet.new(
            expr =>  $<expr>.made,
        )
    }

    method expr-nostruct-base:sym<break>($/) {
        make ExprBreak.new(

        )
    }

    method expr-nostruct-base:sym<break-ident>($/) {
        make ExprBreak.new(
            ident =>  $<ident>.made,
        )
    }

    method expr-nostruct-base:sym<yield>($/) {
        make ExprYield.new(

        )
    }

    method expr-nostruct-base:sym<yield-expr>($/) {
        make ExprYield.new(
            expr =>  $<expr>.made,
        )
    }

    method expr-nostruct-tail:sym<eq-expr>($/) {
        make ExprAssign.new(
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct-tail:sym<shleq-expr>($/) {
        make ExprAssignShl.new(
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct-tail:sym<shreq-expr>($/) {
        make ExprAssignShr.new(
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct-tail:sym<minuseq-expr>($/) {
        make ExprAssignSub.new(
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct-tail:sym<andeq-expr>($/) {
        make ExprAssignBitAnd.new(
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct-tail:sym<oreq-expr>($/) {
        make ExprAssignBitOr.new(
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct-tail:sym<pluseq-expr>($/) {
        make ExprAssignAdd.new(
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct-tail:sym<stareq-expr>($/) {
        make ExprAssignMul.new(
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct-tail:sym<slasheq-expr>($/) {
        make ExprAssignDiv.new(
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct-tail:sym<careteq-expr>($/) {
        make ExprAssignBitXor.new(
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct-tail:sym<percenteq-expr>($/) {
        make ExprAssignRem.new(
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct-tail:sym<oror-expr>($/) {
        make ExprBinary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct-tail:sym<andand-expr>($/) {
        make ExprBinary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct-tail:sym<eqeq-expr>($/) {
        make ExprBinary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct-tail:sym<ne-expr>($/) {
        make ExprBinary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct-tail:sym<lt-expr>($/) {
        make ExprBinary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct-tail:sym<gt-expr>($/) {
        make ExprBinary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct-tail:sym<le-expr>($/) {
        make ExprBinary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct-tai:sym<ge-expr>($/) {
        make ExprBinary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct-tail:sym<pipe-expr>($/) {
        make ExprBinary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct-tail:sym<caret-expr>($/) {
        make ExprBinary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct-tail:sym<amp-expr>($/) {
        make ExprBinary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct-tail:sym<shl-expr>($/) {
        make ExprBinary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct-tail:sym<shr-expr>($/) {
        make ExprBinary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct-tail:sym<plus-expr>($/) {
        make ExprBinary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct-tail:sym<minus-expr>($/) {
        make ExprBinary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct-tail:sym<star-expr>($/) {
        make ExprBinary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct-tail:sym<slash-expr>($/) {
        make ExprBinary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct-tail:sym<mod-expr>($/) {
        make ExprBinary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct-base:sym<dotdot>($/) {
        make ExprRange.new
    }

    method expr-nostruct-tail:sym<dotdot-nostruct>($/) {
        make ExprRange.new(
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct-base:sym<dotdot-expr-nostruct>($/) {
        make ExprRange.new(
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct-tail:sym<dotdot>($/) {
        make ExprRange.new
    }

    method expr-nostruct-tail:sym<as-try>($/) {
        make ExprCast.new(
            ty   =>  $<ty>.made,
        )
    }

    method expr-nostruct-tail:sym<colon-try>($/) {
        make ExprTypeAscr.new(
            ty   =>  $<ty>.made,
        )
    }

    method expr-nostruct-base:sym<box-expr>($/) {
        make ExprBox.new(
            expr =>  $<expr>.made,
        )
    }

    method expr-nostruct-base:sym<expr-qualified-path>($/) {
        make $<expr-qualified-path>.made
    }

    method expr-nostruct-base:sym<block-expr>($/) {
        make $<block-expr>.made
    }

    method expr-nostruct-base:sym<block>($/) {
        make $<block>.made
    }

    method expr-nostruct-base:sym<nonblock-prefix-expr-nostruct>($/) {
        make $<nonblock-prefix-expr-nostruct>.made
    }
}

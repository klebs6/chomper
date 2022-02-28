use grust-model;

#-------------------------------------

our role ExprNoStruct::Rules {

    rule expr-nostruct { <expr-nostruct-base> <expr-nostruct-tail>* }

    #-------------------------
    proto rule expr-nostruct-base { * }

    rule expr-nostruct-base:sym<lit>  { <lit> }

    rule expr-nostruct-base:sym<path-expr>  { 
        #{ self.set-prec(IDENT) } 
        <path-expr> 
    }

    rule expr-nostruct-base:sym<self>                          { <self_> }
    rule expr-nostruct-base:sym<macro-expr>                    { <macro-expr> }
    rule expr-nostruct-base:sym<vec-expr>                      { '[' <vec-expr> ']' }
    rule expr-nostruct-base:sym<paren-expr>                    { '(' <maybe-exprs> ')' }
    rule expr-nostruct-base:sym<continue>                      { <continue_> }
    rule expr-nostruct-base:sym<continue-ident>                { <continue_> <ident> }
    rule expr-nostruct-base:sym<return>                        { <return_> }
    rule expr-nostruct-base:sym<return-expr>                   { <return_> <expr> }
    rule expr-nostruct-base:sym<break>                         { <break_> }
    rule expr-nostruct-base:sym<break-ident>                   { <break_> <ident> }
    rule expr-nostruct-base:sym<yield>                         { <yield> }
    rule expr-nostruct-base:sym<yield-expr>                    { <yield> <expr> }
    rule expr-nostruct-base:sym<dotdot-expr-nostruct>          { <dotdot> <expr-nostruct> }
    rule expr-nostruct-base:sym<dotdot>                        { <dotdot> }
    rule expr-nostruct-base:sym<box-expr>                      { <box> <expr> }
    rule expr-nostruct-base:sym<expr-qualified-path>           { <expr-qualified-path> }

    rule expr-nostruct-base:sym<block-expr>                    { <block-expr> }
    rule expr-nostruct-base:sym<block>                         { <block> }
    rule expr-nostruct-base:sym<nonblock-prefix-expr-nostruct> { <nonblock-prefix-expr-nostruct> }

    #-------------------------
    proto rule expr-nostruct-tail { * }

    rule expr-nostruct-tail:sym<qmark>             { '?' }
    rule expr-nostruct-tail:sym<dot-path>          { '.' <path-generic-args-with-colons> }
    rule expr-nostruct-tail:sym<dot-lit-int>       { '.' <lit-int> }
    rule expr-nostruct-tail:sym<brack-expr>        { '[' <maybe-expr> ']' }
    rule expr-nostruct-tail:sym<paren-expr>        { '(' <maybe-exprs> ')' }

    rule expr-nostruct-tail:sym<eq-expr>           { '='           <expr-nostruct> }
    rule expr-nostruct-tail:sym<shleq-expr>        { <shleq>       <expr-nostruct> }
    rule expr-nostruct-tail:sym<shreq-expr>        { <shreq>       <expr-nostruct> }
    rule expr-nostruct-tail:sym<minuseq-expr>      { <minuseq>     <expr-nostruct> }
    rule expr-nostruct-tail:sym<andeq-expr>        { <andeq>       <expr-nostruct> }
    rule expr-nostruct-tail:sym<oreq-expr>         { <oreq>        <expr-nostruct> }
    rule expr-nostruct-tail:sym<pluseq-expr>       { <pluseq>      <expr-nostruct> }
    rule expr-nostruct-tail:sym<stareq-expr>       { <stareq>      <expr-nostruct> }
    rule expr-nostruct-tail:sym<slasheq-expr>      { <slasheq>     <expr-nostruct> }
    rule expr-nostruct-tail:sym<careteq-expr>      { <careteq>     <expr-nostruct> }
    rule expr-nostruct-tail:sym<percenteq-expr>    { <percenteq>   <expr-nostruct> }
    rule expr-nostruct-tail:sym<oror-expr>         { <oror>        <expr-nostruct> }
    rule expr-nostruct-tail:sym<andand-expr>       { <andand>      <expr-nostruct> }
    rule expr-nostruct-tail:sym<eqeq-expr>         { <eqeq>        <expr-nostruct> }
    rule expr-nostruct-tail:sym<ne-expr>           { <ne_>          <expr-nostruct> }
    rule expr-nostruct-tail:sym<lt-expr>           { '<'           <expr-nostruct> }
    rule expr-nostruct-tail:sym<gt-expr>           { '>'           <expr-nostruct> }
    rule expr-nostruct-tail:sym<le-expr>           { <le_>          <expr-nostruct> }
    rule expr-nostruct-tail:sym<ge-expr>           { <ge_>          <expr-nostruct> }
    rule expr-nostruct-tail:sym<pipe-expr>         { '|'           <expr-nostruct> }
    rule expr-nostruct-tail:sym<caret-expr>        { '^'           <expr-nostruct> }
    rule expr-nostruct-tail:sym<amp-expr>          { '&'           <expr-nostruct> }
    rule expr-nostruct-tail:sym<shl-expr>          { <shl>         <expr-nostruct> }
    rule expr-nostruct-tail:sym<shr-expr>          { <shr>         <expr-nostruct> }
    rule expr-nostruct-tail:sym<plus-expr>         { '+'           <expr-nostruct> }
    rule expr-nostruct-tail:sym<minus-expr>        { '-'           <expr-nostruct> }
    rule expr-nostruct-tail:sym<star-expr>         { '*'           <expr-nostruct> }
    rule expr-nostruct-tail:sym<slash-expr>        { '/'           <expr-nostruct> }
    rule expr-nostruct-tail:sym<mod-expr>          { '%'           <expr-nostruct> }
    rule expr-nostruct-tail:sym<dotdot-nostruct>   { <dotdot>      <expr-nostruct> }

    rule expr-nostruct-tail:sym<dotdot> { 
        <dotdot>      
        #{ self.set-prec(RANGE) } 
    }

    rule expr-nostruct-tail:sym<as-try>    { <as_> <ty> }
    rule expr-nostruct-tail:sym<colon-try> { ':' <ty> }
}

our role ExprNoStruct::Actions {

=begin comment
    method expr-nostruct:sym<lit>($/) {
        make ExprLit.new(
            lit =>  $<lit>.made,
        )
    }

    method expr-nostruct:sym<path-expr>($/) {
        make ExprPath.new(
            path-expr =>  $<path-expr>.made,
        )
    }

    method expr-nostruct:sym<self>($/) {
        make ExprPath.new(

        )
    }

    method expr-nostruct:sym<macro-expr>($/) {
        make ExprMac.new(
            macro-expr =>  $<macro-expr>.made,
        )
    }

    method expr-nostruct:sym<qmark>($/) {
        make ExprTry.new(
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<dot-path>($/) {
        make ExprField.new(
            expr-nostruct                 =>  $<expr-nostruct>.made,
            path-generic-args-with-colons =>  $<path-generic-args-with-colons>.made,
        )
    }

    method expr-nostruct:sym<dot-lit-int>($/) {
        make ExprTupleIndex.new(
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<brack-expr>($/) {
        make ExprIndex.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            maybe-expr    =>  $<maybe-expr>.made,
        )
    }

    method expr-nostruct:sym<paren-expr>($/) {
        make ExprCall.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            maybe-exprs   =>  $<maybe-exprs>.made,
        )
    }

    method expr-nostruct:sym<vec-expr>($/) {
        make ExprVec.new(
            vec-expr =>  $<vec-expr>.made,
        )
    }

    method expr-nostruct:sym<paren-expr>($/) {
        make ExprParen.new(
            maybe-exprs =>  $<maybe-exprs>.made,
        )
    }

    method expr-nostruct:sym<continue>($/) {
        make ExprAgain.new(

        )
    }

    method expr-nostruct:sym<continue-ident>($/) {
        make ExprAgain.new(
            ident =>  $<ident>.made,
        )
    }

    method expr-nostruct:sym<return>($/) {
        make ExprRet.new(

        )
    }

    method expr-nostruct:sym<return-expr>($/) {
        make ExprRet.new(
            expr =>  $<expr>.made,
        )
    }

    method expr-nostruct:sym<break>($/) {
        make ExprBreak.new(

        )
    }

    method expr-nostruct:sym<break-ident>($/) {
        make ExprBreak.new(
            ident =>  $<ident>.made,
        )
    }

    method expr-nostruct:sym<yield>($/) {
        make ExprYield.new(

        )
    }

    method expr-nostruct:sym<yield-expr>($/) {
        make ExprYield.new(
            expr =>  $<expr>.made,
        )
    }

    method expr-nostruct:sym<eq-expr>($/) {
        make ExprAssign.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<shleq-expr>($/) {
        make ExprAssignShl.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<shreq-expr>($/) {
        make ExprAssignShr.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<minuseq-expr>($/) {
        make ExprAssignSub.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<andeq-expr>($/) {
        make ExprAssignBitAnd.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<oreq-expr>($/) {
        make ExprAssignBitOr.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<pluseq-expr>($/) {
        make ExprAssignAdd.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<stareq-expr>($/) {
        make ExprAssignMul.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<slasheq-expr>($/) {
        make ExprAssignDiv.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<careteq-expr>($/) {
        make ExprAssignBitXor.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<percenteq-expr>($/) {
        make ExprAssignRem.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<oror-expr>($/) {
        make ExprBinary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<andand-expr>($/) {
        make ExprBinary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<eqeq-expr>($/) {
        make ExprBinary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<ne-expr>($/) {
        make ExprBinary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<lt-expr>($/) {
        make ExprBinary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<gt-expr>($/) {
        make ExprBinary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<le-expr>($/) {
        make ExprBinary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<ge-expr>($/) {
        make ExprBinary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<pipe-expr>($/) {
        make ExprBinary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<caret-expr>($/) {
        make ExprBinary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<amp-expr>($/) {
        make ExprBinary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<shl-expr>($/) {
        make ExprBinary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<shr-expr>($/) {
        make ExprBinary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<plus-expr>($/) {
        make ExprBinary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<minus-expr>($/) {
        make ExprBinary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<star-expr>($/) {
        make ExprBinary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<slash-expr>($/) {
        make ExprBinary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<mod-expr>($/) {
        make ExprBinary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<dotdot>($/) {
        make ExprRange.new(
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<dotdot-nostruct>($/) {
        make ExprRange.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<dotdot-expr-nostruct>($/) {
        make ExprRange.new(
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-nostruct:sym<dotdot>($/) {
        make ExprRange.new(

        )
    }

    method expr-nostruct:sym<as-try>($/) {
        make ExprCast.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            ty            =>  $<ty>.made,
        )
    }

    method expr-nostruct:sym<colon-try>($/) {
        make ExprTypeAscr.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            ty            =>  $<ty>.made,
        )
    }

    method expr-nostruct:sym<box-expr>($/) {
        make ExprBox.new(
            expr =>  $<expr>.made,
        )
    }

    method expr-nostruct:sym<expr-qualified-path>($/) {
        make $<expr-qualified-path>.made
    }

    method expr-nostruct:sym<block-expr>($/) {
        make $<block-expr>.made
    }

    method expr-nostruct:sym<block>($/) {
        make $<block>.made
    }

    method expr-nostruct:sym<nonblock-prefix-expr-nostruct>($/) {
        make $<nonblock-prefix-expr-nostruct>.made
    }
=end comment
}

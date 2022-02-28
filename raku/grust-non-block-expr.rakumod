use grust-model;

#-------------------------------------

our role NonBlockExpr::Rules {

    rule nonblock-expr {  <nonblock-expr-base> <nonblock-expr-tail>* }

    #---------------------
    proto rule nonblock-expr-base { * }

    rule nonblock-expr-base:sym<lit>  { <lit> }

    rule nonblock-expr-base:sym<path-expr>  { 
        #{self.set-prec(IDENT)} 
        <path-expr> 
    }

    rule nonblock-expr-base:sym<self>                  { <SELF> }
    rule nonblock-expr-base:sym<macro-expr>            { <macro-expr> }
    rule nonblock-expr-base:sym<struct-expr>           { <path-expr> '{' <struct-expr-fields> '}' }
    rule nonblock-expr-base:sym<vec-expr>              { '[' <vec-expr> ']' }
    rule nonblock-expr-base:sym<paren-expr>            { '(' <maybe-exprs> ')' }
    rule nonblock-expr-base:sym<continue>              { <CONTINUE> }
    rule nonblock-expr-base:sym<continue-lt>           { <CONTINUE> <lifetime> }
    rule nonblock-expr-base:sym<return>                { <RETURN> }
    rule nonblock-expr-base:sym<return-expr>           { <RETURN> <expr> }
    rule nonblock-expr-base:sym<break>                 { <BREAK> }
    rule nonblock-expr-base:sym<break-lt>              { <BREAK> <lifetime> }
    rule nonblock-expr-base:sym<yield>                 { <YIELD> }
    rule nonblock-expr-base:sym<yield-expr>            { <YIELD> <expr> }
    rule nonblock-expr-base:sym<dotdot-expr>           { <DOTDOT> <expr> }
    rule nonblock-expr-base:sym<dotdot>                { <DOTDOT> }
    rule nonblock-expr-base:sym<box-expr>              { <BOX> <expr> }
    rule nonblock-expr-base:sym<expr-qualified-path>   { <expr-qualified-path> }
    rule nonblock-expr-base:sym<nonblock-prefix-expr>  { <nonblock-prefix-expr> }

    #------------------------
    proto rule nonblock-expr-tail { * }
    rule nonblock-expr-tail:sym<qmark>              { '?' }
    rule nonblock-expr-tail:sym<dot-path>           { '.' <path-generic-args-with-colons> }
    rule nonblock-expr-tail:sym<dot-lit-int>        { '.' <LIT-INT> }
    rule nonblock-expr-tail:sym<brack-expr>         { '[' <maybe-expr> ']' }
    rule nonblock-expr-tail:sym<parens-expr>        { '(' <maybe-exprs> ')' }
    rule nonblock-expr-tail:sym<eq-expr>            { '=' <expr> }
    rule nonblock-expr-tail:sym<shleq-expr>         { <SHLEQ> <expr> }
    rule nonblock-expr-tail:sym<shreq-expr>         { <SHREQ> <expr> }
    rule nonblock-expr-tail:sym<minuseq-expr>       { <MINUSEQ> <expr> }
    rule nonblock-expr-tail:sym<andeq-expr>         { <ANDEQ> <expr> }
    rule nonblock-expr-tail:sym<oreq-expr>          { <OREQ> <expr> }
    rule nonblock-expr-tail:sym<pluseq-expr>        { <PLUSEQ> <expr> }
    rule nonblock-expr-tail:sym<stareq-expr>        { <STAREQ> <expr> }
    rule nonblock-expr-tail:sym<slasheq-expr>       { <SLASHEQ> <expr> }
    rule nonblock-expr-tail:sym<careteq-expr>       { <CARETEQ> <expr> }
    rule nonblock-expr-tail:sym<percenteq-expr>     { <PERCENTEQ> <expr> }
    rule nonblock-expr-tail:sym<oror-expr>          { <OROR> <expr> }
    rule nonblock-expr-tail:sym<andand-expr>        { <ANDAND> <expr> }
    rule nonblock-expr-tail:sym<eqeq-expr>          { <EQEQ> <expr> }
    rule nonblock-expr-tail:sym<ne-expr>            { <NE> <expr> }
    rule nonblock-expr-tail:sym<lt-expr>            { '<' <expr> }
    rule nonblock-expr-tail:sym<gt-expr>            { '>' <expr> }
    rule nonblock-expr-tail:sym<le-expr>            { <LE> <expr> }
    rule nonblock-expr-tail:sym<ge-expr>            { <GE> <expr> }
    rule nonblock-expr-tail:sym<pipe-expr>          { '|' <expr> }
    rule nonblock-expr-tail:sym<caret-expr>         { '^' <expr> }
    rule nonblock-expr-tail:sym<amp-expr>           { '&' <expr> }
    rule nonblock-expr-tail:sym<shl-expr>           { <SHL> <expr> }
    rule nonblock-expr-tail:sym<shr-expr>           { <SHR> <expr> }
    rule nonblock-expr-tail:sym<plus-expr>          { '+' <expr> }
    rule nonblock-expr-tail:sym<minus-expr>         { '-' <expr> }
    rule nonblock-expr-tail:sym<star-expr>          { '*' <expr> }
    rule nonblock-expr-tail:sym<slash-expr>         { '/' <expr> }
    rule nonblock-expr-tail:sym<mod-expr>           { '%' <expr> }
    rule nonblock-expr-tail:sym<dotdot>             { <DOTDOT> }
    rule nonblock-expr-tail:sym<dotdot-expr>        { <DOTDOT> <expr> }
    rule nonblock-expr-tail:sym<as-ty>              { <AS> <ty> }
    rule nonblock-expr-tail:sym<colon-ty>           { ':' <ty> }
}

our role NonBlockExpr::Actions {

=begin comment
    method nonblock-expr:sym<lit>($/) {
        make ExprLit.new(
            lit =>  $<lit>.made,
        )
    }

    method nonblock-expr:sym<path-expr>($/) {
        make ExprPath.new(
            path-expr =>  $<path-expr>.made,
        )
    }

    method nonblock-expr:sym<self>($/) {
        make ExprPath.new(

        )
    }

    method nonblock-expr:sym<macro-expr>($/) {
        make ExprMac.new(
            macro-expr =>  $<macro-expr>.made,
        )
    }

    method nonblock-expr:sym<struct-expr>($/) {
        make ExprStruct.new(
            path-expr          =>  $<path-expr>.made,
            struct-expr-fields =>  $<struct-expr-fields>.made,
        )
    }

    method nonblock-expr:sym<f>($/) {
        make ExprTry.new(
            nonblock-expr =>  $<nonblock-expr>.made,
        )
    }

    method nonblock-expr:sym<dot-path>($/) {
        make ExprField.new(
            nonblock-expr                 =>  $<nonblock-expr>.made,
            path-generic-args-with-colons =>  $<path-generic-args-with-colons>.made,
        )
    }

    method nonblock-expr:sym<dot-lit-int>($/) {
        make ExprTupleIndex.new(
            nonblock-expr =>  $<nonblock-expr>.made,
        )
    }

    method nonblock-expr:sym<brack-expr>($/) {
        make ExprIndex.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            maybe-expr    =>  $<maybe-expr>.made,
        )
    }

    method nonblock-expr:sym<parens-expr>($/) {
        make ExprCall.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            maybe-exprs   =>  $<maybe-exprs>.made,
        )
    }

    method nonblock-expr:sym<vec-expr>($/) {
        make ExprVec.new(
            vec-expr =>  $<vec-expr>.made,
        )
    }

    method nonblock-expr:sym<paren-expr>($/) {
        make ExprParen.new(
            maybe-exprs =>  $<maybe-exprs>.made,
        )
    }

    method nonblock-expr:sym<continue>($/) {
        make ExprAgain.new(

        )
    }

    method nonblock-expr:sym<continue-lt>($/) {
        make ExprAgain.new(
            lifetime =>  $<lifetime>.made,
        )
    }

    method nonblock-expr:sym<return>($/) {
        make ExprRet.new(

        )
    }

    method nonblock-expr:sym<return-expr>($/) {
        make ExprRet.new(
            expr =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<break>($/) {
        make ExprBreak.new(

        )
    }

    method nonblock-expr:sym<break-lt>($/) {
        make ExprBreak.new(
            lifetime =>  $<lifetime>.made,
        )
    }

    method nonblock-expr:sym<yield>($/) {
        make ExprYield.new(

        )
    }

    method nonblock-expr:sym<yield-expr>($/) {
        make ExprYield.new(
            expr =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<eq-expr>($/) {
        make ExprAssign.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<shleq-expr>($/) {
        make ExprAssignShl.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<shreq-expr>($/) {
        make ExprAssignShr.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<minuseq-expr>($/) {
        make ExprAssignSub.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<andeq-expr>($/) {
        make ExprAssignBitAnd.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<oreq-expr>($/) {
        make ExprAssignBitOr.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<pluseq-expr>($/) {
        make ExprAssignAdd.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<stareq-expr>($/) {
        make ExprAssignMul.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<slasheq-expr>($/) {
        make ExprAssignDiv.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<careteq-expr>($/) {
        make ExprAssignBitXor.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<percenteq-expr>($/) {
        make ExprAssignRem.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<oror-expr>($/) {
        make ExprBinary.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<andand-expr>($/) {
        make ExprBinary.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<eqeq-expr>($/) {
        make ExprBinary.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<ne-expr>($/) {
        make ExprBinary.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<lt-expr>($/) {
        make ExprBinary.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<gt-expr>($/) {
        make ExprBinary.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<le-expr>($/) {
        make ExprBinary.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<ge-expr>($/) {
        make ExprBinary.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<pipe-expr>($/) {
        make ExprBinary.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<caret-expr>($/) {
        make ExprBinary.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<amp-expr>($/) {
        make ExprBinary.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<shl-expr>($/) {
        make ExprBinary.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<shr-expr>($/) {
        make ExprBinary.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<plus-expr>($/) {
        make ExprBinary.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<minus-expr>($/) {
        make ExprBinary.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<star-expr>($/) {
        make ExprBinary.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<slash-expr>($/) {
        make ExprBinary.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<mod-expr>($/) {
        make ExprBinary.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<dotdot>($/) {
        make ExprRange.new(
            nonblock-expr =>  $<nonblock-expr>.made,
        )
    }

    method nonblock-expr:sym<dotdot-expr>($/) {
        make ExprRange.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            expr          =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<dotdot-expr>($/) {
        make ExprRange.new(
            expr =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<dotdot>($/) {
        make ExprRange.new(

        )
    }

    method nonblock-expr:sym<as-ty>($/) {
        make ExprCast.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            ty            =>  $<ty>.made,
        )
    }

    method nonblock-expr:sym<colon-ty>($/) {
        make ExprTypeAscr.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            ty            =>  $<ty>.made,
        )
    }

    method nonblock-expr:sym<box-expr>($/) {
        make ExprBox.new(
            expr =>  $<expr>.made,
        )
    }

    method nonblock-expr:sym<expr-qualified-path>($/) {
        make $<expr-qualified-path>.made
    }

    method nonblock-expr:sym<nonblock-prefix-expr>($/) {
        make $<nonblock-prefix-expr>.made
    }
=end comment
}

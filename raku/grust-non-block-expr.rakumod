use grust-model-expr;

#-------------------------------------

our role NonBlockExpr::Rules {

    rule nonblock-expr {  
        <comment>? 
        <nonblock-expr-base> 
        <nonblock-expr-tail>* 
    }

    #---------------------
    proto rule nonblock-expr-base { * }

    rule nonblock-expr-base:sym<lit>                   { <lit> }
    rule nonblock-expr-base:sym<self>                  { <kw-self> }
    rule nonblock-expr-base:sym<macro-expr>            { <macro-expr> }
    rule nonblock-expr-base:sym<struct-expr>           { <path-expr> '{' <struct-expr-fields> '}' }
    rule nonblock-expr-base:sym<vec-expr>              { '[' <vec-expr> ']' }
    rule nonblock-expr-base:sym<paren-expr>            { '(' <maybe-exprs> ')' }
    rule nonblock-expr-base:sym<continue-lt>           { <kw-continue> <lifetime> }
    rule nonblock-expr-base:sym<continue>              { <kw-continue> }
    rule nonblock-expr-base:sym<return-expr>           { <kw-return> <expr> }
    rule nonblock-expr-base:sym<return>                { <kw-return> }
    rule nonblock-expr-base:sym<break-lt>              { <kw-break> <lifetime> }
    rule nonblock-expr-base:sym<break>                 { <kw-break> }
    rule nonblock-expr-base:sym<yield-expr>            { <kw-yield> <expr> }
    rule nonblock-expr-base:sym<yield>                 { <kw-yield> }
    rule nonblock-expr-base:sym<dotdot-expr>           { <tok-dotdot> <expr> }
    rule nonblock-expr-base:sym<dotdot>                { <tok-dotdot> }
    rule nonblock-expr-base:sym<box-expr>              { <kw-box> <expr> }
    rule nonblock-expr-base:sym<expr-qualified-path>   { <expr-qualified-path> }
    rule nonblock-expr-base:sym<nonblock-prefix-expr>  { <nonblock-prefix-expr> }
    rule nonblock-expr-base:sym<path-expr>             { <path-expr> }

    #------------------------
    proto rule nonblock-expr-tail { * }
    rule nonblock-expr-tail:sym<qmark>              { '?' }
    rule nonblock-expr-tail:sym<dot-path>           { '.' <path-generic-args-with-colons> }
    rule nonblock-expr-tail:sym<dot-lit-int>        { '.' <lit-int> }
    rule nonblock-expr-tail:sym<brack-expr>         { '[' <maybe-expr> ']' }
    rule nonblock-expr-tail:sym<parens-expr>        { '(' <maybe-exprs> ')' }
    rule nonblock-expr-tail:sym<eq-expr>            { '=' <expr> }
    rule nonblock-expr-tail:sym<shleq-expr>         { <tok-shleq> <expr> }
    rule nonblock-expr-tail:sym<shreq-expr>         { <tok-shreq> <expr> }
    rule nonblock-expr-tail:sym<minuseq-expr>       { <tok-minuseq> <expr> }
    rule nonblock-expr-tail:sym<andeq-expr>         { <tok-andeq> <expr> }
    rule nonblock-expr-tail:sym<oreq-expr>          { <tok-oreq> <expr> }
    rule nonblock-expr-tail:sym<pluseq-expr>        { <tok-pluseq> <expr> }
    rule nonblock-expr-tail:sym<stareq-expr>        { <tok-stareq> <expr> }
    rule nonblock-expr-tail:sym<slasheq-expr>       { <tok-slasheq> <expr> }
    rule nonblock-expr-tail:sym<careteq-expr>       { <tok-careteq> <expr> }
    rule nonblock-expr-tail:sym<percenteq-expr>     { <tok-percenteq> <expr> }
    rule nonblock-expr-tail:sym<oror-expr>          { <tok-oror> <expr> }
    rule nonblock-expr-tail:sym<andand-expr>        { <tok-andand> <expr> }
    rule nonblock-expr-tail:sym<eqeq-expr>          { <tok-eqeq> <expr> }
    rule nonblock-expr-tail:sym<ne-expr>            { <tok-ne> <expr> }
    rule nonblock-expr-tail:sym<lt-expr>            { '<' <expr> }
    rule nonblock-expr-tail:sym<gt-expr>            { '>' <expr> }
    rule nonblock-expr-tail:sym<le-expr>            { <tok-le> <expr> }
    rule nonblock-expr-tail:sym<ge-expr>            { <tok-ge> <expr> }
    rule nonblock-expr-tail:sym<pipe-expr>          { '|' <expr> }
    rule nonblock-expr-tail:sym<caret-expr>         { '^' <expr> }
    rule nonblock-expr-tail:sym<amp-expr>           { '&' <expr> }
    rule nonblock-expr-tail:sym<shl-expr>           { <tok-shl> <expr> }
    rule nonblock-expr-tail:sym<shr-expr>           { <tok-shr> <expr> }
    rule nonblock-expr-tail:sym<plus-expr>          { '+' <expr> }
    rule nonblock-expr-tail:sym<minus-expr>         { '-' <expr> }
    rule nonblock-expr-tail:sym<star-expr>          { '*' <expr> }
    rule nonblock-expr-tail:sym<slash-expr>         { '/' <expr> }
    rule nonblock-expr-tail:sym<mod-expr>           { '%' <expr> }
    rule nonblock-expr-tail:sym<dotdot>             { <tok-dotdot> }
    rule nonblock-expr-tail:sym<dotdot-expr>        { <tok-dotdot> <expr> }
    rule nonblock-expr-tail:sym<as-ty>              { <kw-as> <ty> }
    rule nonblock-expr-tail:sym<colon-ty>           { ':' <ty> }
}

our role NonBlockExpr::Actions {

    method nonblock-expr($/) {  
        make NonBlockExpr.new(
            comment => $<comment>.made,
            base    => $<nonblock-expr-base>.made,
            tail    => $<nonblock-expr-tail>>>.made,
            text    => ~$/,
        )
    }

    method nonblock-expr-base:sym<lit>($/) {
        make ExprLit.new(
            lit  =>  $<lit>.made,
            text => ~$/,
        )
    }

    method nonblock-expr-base:sym<path-expr>($/) {
        make ExprPath.new(
            path-expr =>  $<path-expr>.made,
            text      => ~$/,
        )
    }

    method nonblock-expr-base:sym<self>($/) {
        make Self.new(
            text      => ~$/,
        )
    }

    method nonblock-expr-base:sym<macro-expr>($/) {
        make ExprMac.new(
            macro-expr =>  $<macro-expr>.made,
            text       => ~$/,
        )
    }

    method nonblock-expr-base:sym<struct-expr>($/) {
        make ExprStruct.new(
            path-expr          =>  $<path-expr>.made,
            struct-expr-fields =>  $<struct-expr-fields>.made,
            text               => ~$/,
        )
    }

    method nonblock-expr:sym<f>($/) {
        make ExprTry.new(
            nonblock-expr => $<nonblock-expr>.made,
            text          => ~$/,
        )
    }

    method nonblock-expr-tail:sym<dot-path>($/) {
        make ExprField.new(
            path-generic-args-with-colons => $<path-generic-args-with-colons>.made,
            text                          => ~$/,
        )
    }

    method nonblock-expr-tail:sym<dot-lit-int>($/) {
        make ExprTupleIndex.new(
            lit-int =>  $<lit-int>.made,
            text    => ~$/,
        )
    }

    method nonblock-expr-tail:sym<brack-expr>($/) {
        make ExprIndex.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            maybe-expr    =>  $<maybe-expr>.made,
            text          => ~$/,
        )
    }

    method nonblock-expr-tail:sym<parens-expr>($/) {
        make ExprCall.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            maybe-exprs   =>  $<maybe-exprs>.made,
            text          => ~$/,
        )
    }

    method nonblock-expr-base:sym<vec-expr>($/) {
        make ExprVec.new(
            vec-expr =>  $<vec-expr>.made,
            text     => ~$/,
        )
    }

    method nonblock-expr-base:sym<paren-expr>($/) {
        make ExprParen.new(
            maybe-exprs =>  $<maybe-exprs>.made,
            text        => ~$/,
        )
    }

    method nonblock-expr-base:sym<continue>($/) {
        make ExprAgain.new(
            text        => ~$/,
        )
    }

    method nonblock-expr-base:sym<continue-lt>($/) {
        make ExprAgain.new(
            lifetime =>  $<lifetime>.made,
            text     => ~$/,
        )
    }

    method nonblock-expr-base:sym<return>($/) {
        make ExprRet.new(
            text     => ~$/,
        )
    }

    method nonblock-expr-base:sym<return-expr>($/) {
        make ExprRet.new(
            expr => $<expr>.made,
            text => ~$/,
        )
    }

    method nonblock-expr-base:sym<break>($/) {
        make ExprBreak.new(
            text => ~$/,
        )
    }

    method nonblock-expr-base:sym<break-lt>($/) {
        make ExprBreak.new(
            lifetime =>  $<lifetime>.made,
            text     => ~$/,
        )
    }

    method nonblock-expr-base:sym<yield>($/) {
        make ExprYield.new(
            text     => ~$/,
        )
    }

    method nonblock-expr-base:sym<yield-expr>($/) {
        make ExprYield.new(
            expr =>  $<expr>.made,
            text => ~$/,
        )
    }

    method nonblock-expr-tail:sym<eq-expr>($/) {
        make ExprAssign.new(
            expr =>  $<expr>.made,
            text => ~$/,
        )
    }

    method nonblock-expr-tail:sym<shleq-expr>($/) {
        make ExprAssignShl.new(
            expr =>  $<expr>.made,
            text => ~$/,
        )
    }

    method nonblock-expr-tail:sym<shreq-expr>($/) {
        make ExprAssignShr.new(
            expr =>  $<expr>.made,
            text => ~$/,
        )
    }

    method nonblock-expr-tail:sym<minuseq-expr>($/) {
        make ExprAssignSub.new(
            expr => $<expr>.made,
            text => ~$/,
        )
    }

    method nonblock-expr-tail:sym<andeq-expr>($/) {
        make ExprAssignBitAnd.new(
            expr => $<expr>.made,
            text => ~$/,
        )
    }

    method nonblock-expr-tail:sym<oreq-expr>($/) {
        make ExprAssignBitOr.new(
            expr => $<expr>.made,
            text => ~$/,
        )
    }

    method nonblock-expr-tail:sym<pluseq-expr>($/) {
        make ExprAssignAdd.new(
            expr => $<expr>.made,
            text => ~$/,
        )
    }

    method nonblock-expr-tail:sym<stareq-expr>($/) {
        make ExprAssignMul.new(
            expr => $<expr>.made,
            text => ~$/,
        )
    }

    method nonblock-expr-tail:sym<slasheq-expr>($/) {
        make ExprAssignDiv.new(
            expr => $<expr>.made,
            text => ~$/,
        )
    }

    method nonblock-expr-tail:sym<careteq-expr>($/) {
        make ExprAssignBitXor.new(
            expr => $<expr>.made,
            text => ~$/,
        )
    }

    method nonblock-expr-tail:sym<percenteq-expr>($/) {
        make ExprAssignRem.new(
            expr => $<expr>.made,
            text => ~$/,
        )
    }

    method nonblock-expr-tail:sym<oror-expr>($/) {
        make ExprBinary.new(
            expr => $<expr>.made,
            text => ~$/,
        )
    }

    method nonblock-expr-tail:sym<andand-expr>($/) {
        make ExprBinary.new(
            expr => $<expr>.made,
            text => ~$/,
        )
    }

    method nonblock-expr-tail:sym<eqeq-expr>($/) {
        make ExprBinary.new(
            expr => $<expr>.made,
            text => ~$/,
        )
    }

    method nonblock-expr-tail:sym<ne-expr>($/) {
        make ExprBinary.new(
            expr => $<expr>.made,
            text => ~$/,
        )
    }

    method nonblock-expr-tail:sym<lt-expr>($/) {
        make ExprBinary.new(
            expr => $<expr>.made,
            text => ~$/,
        )
    }

    method nonblock-expr-tail:sym<gt-expr>($/) {
        make ExprBinary.new(
            expr => $<expr>.made,
            text => ~$/,
        )
    }

    method nonblock-expr-tail:sym<le-expr>($/) {
        make ExprBinary.new(
            expr => $<expr>.made,
            text => ~$/,
        )
    }

    method nonblock-expr-tail:sym<ge-expr>($/) {
        make ExprBinary.new(
            expr => $<expr>.made,
            text => ~$/,
        )
    }

    method nonblock-expr-tail:sym<pipe-expr>($/) {
        make ExprBinary.new(
            expr => $<expr>.made,
            text => ~$/,
        )
    }

    method nonblock-expr-tail:sym<caret-expr>($/) {
        make ExprBinary.new(
            expr => $<expr>.made,
            text => ~$/,
        )
    }

    method nonblock-expr-tail:sym<amp-expr>($/) {
        make ExprBinary.new(
            expr => $<expr>.made,
            text => ~$/,
        )
    }

    method nonblock-expr-tail:sym<shl-expr>($/) {
        make ExprBinary.new(
            expr => $<expr>.made,
            text => ~$/,
        )
    }

    method nonblock-expr-tail:sym<shr-expr>($/) {
        make ExprBinary.new(
            expr => $<expr>.made,
            text => ~$/,
        )
    }

    method nonblock-expr-tail:sym<plus-expr>($/) {
        make ExprBinary.new(
            expr => $<expr>.made,
            text => ~$/,
        )
    }

    method nonblock-expr-tail:sym<minus-expr>($/) {
        make ExprBinary.new(
            expr => $<expr>.made,
            text => ~$/,
        )
    }

    method nonblock-expr-tail:sym<star-expr>($/) {
        make ExprBinary.new(
            expr => $<expr>.made,
            text => ~$/,
        )
    }

    method nonblock-expr-tail:sym<slash-expr>($/) {
        make ExprBinary.new(
            expr => $<expr>.made,
            text => ~$/,
        )
    }

    method nonblock-expr-tail:sym<mod-expr>($/) {
        make ExprBinary.new(
            expr =>  $<expr>.made,
            text => ~$/,
        )
    }

    method nonblock-expr-base:sym<dotdot>($/) {
        make ExprRange.new(
            nonblock-expr =>  $<nonblock-expr>.made,
            text          => ~$/,
        )
    }

    method nonblock-expr-base:sym<dotdot-expr>($/) {
        make ExprRange.new(
            expr =>  $<expr>.made,
            text => ~$/,
        )
    }

    method nonblock-expr-tail:sym<dotdot-expr>($/) {
        make ExprRange.new(
            expr =>  $<expr>.made,
            text => ~$/,
        )
    }

    method nonblock-expr-tail:sym<dotdot>($/) {
        make ExprRange.new(
            text => ~$/,
        )
    }

    method nonblock-expr-tail:sym<as-ty>($/) {
        make ExprCast.new(
            ty   => $<ty>.made,
            text => ~$/,
        )
    }

    method nonblock-expr-tail:sym<colon-ty>($/) {
        make ExprTypeAscr.new(
            ty   => $<ty>.made,
            text => ~$/,
        )
    }

    method nonblock-expr-base:sym<box-expr>($/) {
        make ExprBox.new(
            expr => $<expr>.made,
            text => ~$/,
        )
    }

    method nonblock-expr-base:sym<expr-qualified-path>($/) {
        make $<expr-qualified-path>.made
    }

    method nonblock-expr-base:sym<nonblock-prefix-expr>($/) {
        make $<nonblock-prefix-expr>.made
    }
}

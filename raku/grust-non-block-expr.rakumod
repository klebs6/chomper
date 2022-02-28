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

    rule nonblock-expr-base:sym<self>                  { <self_> }
    rule nonblock-expr-base:sym<macro-expr>            { <macro-expr> }
    rule nonblock-expr-base:sym<struct-expr>           { <path-expr> '{' <struct-expr-fields> '}' }
    rule nonblock-expr-base:sym<vec-expr>              { '[' <vec-expr> ']' }
    rule nonblock-expr-base:sym<paren-expr>            { '(' <maybe-exprs> ')' }
    rule nonblock-expr-base:sym<continue>              { <continue_> }
    rule nonblock-expr-base:sym<continue-lt>           { <continue_> <lifetime> }
    rule nonblock-expr-base:sym<return>                { <return_> }
    rule nonblock-expr-base:sym<return-expr>           { <return_> <expr> }
    rule nonblock-expr-base:sym<break>                 { <kw-break> }
    rule nonblock-expr-base:sym<break-lt>              { <kw-break> <lifetime> }
    rule nonblock-expr-base:sym<yield>                 { <yield> }
    rule nonblock-expr-base:sym<yield-expr>            { <yield> <expr> }
    rule nonblock-expr-base:sym<dotdot-expr>           { <dotdot> <expr> }
    rule nonblock-expr-base:sym<dotdot>                { <dotdot> }
    rule nonblock-expr-base:sym<box-expr>              { <kw-box> <expr> }
    rule nonblock-expr-base:sym<expr-qualified-path>   { <expr-qualified-path> }
    rule nonblock-expr-base:sym<nonblock-prefix-expr>  { <nonblock-prefix-expr> }

    #------------------------
    proto rule nonblock-expr-tail { * }
    rule nonblock-expr-tail:sym<qmark>              { '?' }
    rule nonblock-expr-tail:sym<dot-path>           { '.' <path-generic-args-with-colons> }
    rule nonblock-expr-tail:sym<dot-lit-int>        { '.' <lit-int> }
    rule nonblock-expr-tail:sym<brack-expr>         { '[' <maybe-expr> ']' }
    rule nonblock-expr-tail:sym<parens-expr>        { '(' <maybe-exprs> ')' }
    rule nonblock-expr-tail:sym<eq-expr>            { '=' <expr> }
    rule nonblock-expr-tail:sym<shleq-expr>         { <shleq> <expr> }
    rule nonblock-expr-tail:sym<shreq-expr>         { <shreq> <expr> }
    rule nonblock-expr-tail:sym<minuseq-expr>       { <minuseq> <expr> }
    rule nonblock-expr-tail:sym<andeq-expr>         { <andeq> <expr> }
    rule nonblock-expr-tail:sym<oreq-expr>          { <oreq> <expr> }
    rule nonblock-expr-tail:sym<pluseq-expr>        { <pluseq> <expr> }
    rule nonblock-expr-tail:sym<stareq-expr>        { <stareq> <expr> }
    rule nonblock-expr-tail:sym<slasheq-expr>       { <slasheq> <expr> }
    rule nonblock-expr-tail:sym<careteq-expr>       { <careteq> <expr> }
    rule nonblock-expr-tail:sym<percenteq-expr>     { <percenteq> <expr> }
    rule nonblock-expr-tail:sym<oror-expr>          { <oror> <expr> }
    rule nonblock-expr-tail:sym<andand-expr>        { <andand> <expr> }
    rule nonblock-expr-tail:sym<eqeq-expr>          { <eqeq> <expr> }
    rule nonblock-expr-tail:sym<ne-expr>            { <ne_> <expr> }
    rule nonblock-expr-tail:sym<lt-expr>            { '<' <expr> }
    rule nonblock-expr-tail:sym<gt-expr>            { '>' <expr> }
    rule nonblock-expr-tail:sym<le-expr>            { <le_> <expr> }
    rule nonblock-expr-tail:sym<ge-expr>            { <ge_> <expr> }
    rule nonblock-expr-tail:sym<pipe-expr>          { '|' <expr> }
    rule nonblock-expr-tail:sym<caret-expr>         { '^' <expr> }
    rule nonblock-expr-tail:sym<amp-expr>           { '&' <expr> }
    rule nonblock-expr-tail:sym<shl-expr>           { <shl> <expr> }
    rule nonblock-expr-tail:sym<shr-expr>           { <shr> <expr> }
    rule nonblock-expr-tail:sym<plus-expr>          { '+' <expr> }
    rule nonblock-expr-tail:sym<minus-expr>         { '-' <expr> }
    rule nonblock-expr-tail:sym<star-expr>          { '*' <expr> }
    rule nonblock-expr-tail:sym<slash-expr>         { '/' <expr> }
    rule nonblock-expr-tail:sym<mod-expr>           { '%' <expr> }
    rule nonblock-expr-tail:sym<dotdot>             { <dotdot> }
    rule nonblock-expr-tail:sym<dotdot-expr>        { <dotdot> <expr> }
    rule nonblock-expr-tail:sym<as-ty>              { <kw-as> <ty> }
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

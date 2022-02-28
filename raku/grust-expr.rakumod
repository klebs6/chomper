use grust-model;

our role Expr::Rules {

    proto rule expr-tail{ * }

    rule expr-tail:sym<expr-q>                        { '?' }
    rule expr-tail:sym<dotted-expr>                   { '.' <path-generic-args-with-colons> }
    rule expr-tail:sym<dotted-expr-lit>               { '.' <lit-int> }
    rule expr-tail:sym<expr-bracket-tail>             { '[' <maybe-expr> ']' }
    rule expr-tail:sym<expr-paren-tail>               { '(' <maybe-exprs> ')' }
    rule expr-tail:sym<expr-eq-expr>                  { '=' <expr> }
    rule expr-tail:sym<expr-shleq-expr>               { <shleq> <expr> }
    rule expr-tail:sym<expr-shreq-expr>               { <shreq> <expr> }
    rule expr-tail:sym<expr-minuseq-expr>             { <minuseq> <expr> }
    rule expr-tail:sym<expr-andeq-expr>               { <andeq> <expr> }
    rule expr-tail:sym<expr-oreq-expr>                { <oreq> <expr> }
    rule expr-tail:sym<expr-pluseq-expr>              { <pluseq> <expr> }
    rule expr-tail:sym<expr-stareq-expr>              { <stareq> <expr> }
    rule expr-tail:sym<expr-slasheq-expr>             { <slasheq> <expr> }
    rule expr-tail:sym<expr-careteq-expr>             { <careteq> <expr> }
    rule expr-tail:sym<expr-percenteq-expr>           { <percenteq> <expr> }
    rule expr-tail:sym<expr-oror-expr>                { <oror> <expr> }
    rule expr-tail:sym<expr-andand-expr>              { <andand> <expr> }
    rule expr-tail:sym<expr-eqeq-expr>                { <eqeq> <expr> }
    rule expr-tail:sym<expr-ne-expr>                  { <ne_> <expr> }
    rule expr-tail:sym<expr-lt-expr>                  { '<' <expr> }
    rule expr-tail:sym<expr-gt-expr>                  { '>' <expr> }
    rule expr-tail:sym<expr-le-expr>                  { <le_> <expr> }
    rule expr-tail:sym<expr-ge-expr>                  { <ge_> <expr> }
    rule expr-tail:sym<expr-pipe-expr>                { '|' <expr> }
    rule expr-tail:sym<expr-caret-expr>               { '^' <expr> }
    rule expr-tail:sym<expr-amp-expr>                 { '&' <expr> }
    rule expr-tail:sym<expr-shl-expr>                 { <shl> <expr> }
    rule expr-tail:sym<expr-shr-expr>                 { <shr> <expr> }
    rule expr-tail:sym<expr-plus-expr>                { '+' <expr> }
    rule expr-tail:sym<expr-minus-expr>               { '-' <expr> }
    rule expr-tail:sym<expr-star-expr>                { '*' <expr> }
    rule expr-tail:sym<expr-slash-expr>               { '/' <expr> }
    rule expr-tail:sym<expr-mod-expr>                 { '%' <expr> }
    rule expr-tail:sym<expr-dotdot>                   { <dotdot> }
    rule expr-tail:sym<expr-dotdot-expr>              { <dotdot> <expr> }
    rule expr-tail:sym<expr-as-ty>                    { <as_> <ty> }
    rule expr-tail:sym<expr-ty>                       { ':' <ty> }

    proto rule expr-base { * }

    rule expr-base:sym<lit>  { <lit> }
    rule expr-base:sym<self> { <self_> }

    rule expr-base:sym<macro-expr>                    { <macro-expr> }

    rule expr-base:sym<path-expr> { 
        #{self.set-prec(IDENT)} 
        <path-expr> 
    }

    rule expr-base:sym<struct-expr>                   { <path-expr> '{' <struct-expr-fields> '}' }
    rule expr-base:sym<paren-tail>                    { '(' <maybe-exprs> ')' }
    rule expr-base:sym<brack-tail>                    { '[' <vec-expr> ']' }
    rule expr-base:sym<continue>                      { <continue_> }
    rule expr-base:sym<continue-ident>                { <continue_> <ident> }
    rule expr-base:sym<return>                        { <return_> }
    rule expr-base:sym<break>                         { <break_> }
    rule expr-base:sym<break-ident>                   { <break_> <ident> }
    rule expr-base:sym<yield>                         { <yield> }
    rule expr-base:sym<dotdot>                        { <dotdot> }
    rule expr-base:sym<expr-qualified-path>           { <expr-qualified-path> }
    rule expr-base:sym<block-expr>                    { <block-expr> }
    rule expr-base:sym<block>                         { <block> }
    rule expr-base:sym<nonblock-prefix-expr>          { <nonblock-prefix-expr> }

    proto rule expr-prefix { * }
    rule expr-prefix:sym<return-expr>   { <return_> }
    rule expr-prefix:sym<yield-expr>    { <yield>  }
    rule expr-prefix:sym<dotdot-expr>   { <dotdot> }
    rule expr-prefix:sym<box-expr>      { <box>    }

    rule expr {
        <expr-prefix>* 
        <expr-base> 
        <expr-tail>*
    }
}

our role Expr::Actions {
=begin comment

    method expr:sym<lit>($/) {
        make ExprLit.new(
            lit =>  $<lit>.made,
        )
    }

    method expr:sym<self>($/) {
        make ExprPath.new(

        )
    }

    method expr:sym<path-expr>($/) {
        make ExprPath.new(
            path-expr =>  $<path-expr>.made,
        )
    }

    method expr:sym<macro-expr>($/) {
        make ExprMac.new(
            macro-expr =>  $<macro-expr>.made,
        )
    }

    method expr:sym<struct-expr>($/) {
        make ExprStruct.new(
            path-expr          =>  $<path-expr>.made,
            struct-expr-fields =>  $<struct-expr-fields>.made,
        )
    }

    method expr:sym<expr-q>($/) {
        make ExprTry.new(
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<dotted-expr>($/) {
        make ExprField.new(
            expr                          =>  $<expr>.made,
            path-generic-args-with-colons =>  $<path-generic-args-with-colons>.made,
        )
    }

    method expr:sym<dotted-expr-lit>($/) {
        make ExprTupleIndex.new(
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<expr-bracket-tail>($/) {
        make ExprIndex.new(
            expr       =>  $<expr>.made,
            maybe-expr =>  $<maybe-expr>.made,
        )
    }

    method expr:sym<expr-paren-tail>($/) {
        make ExprCall.new(
            expr        =>  $<expr>.made,
            maybe-exprs =>  $<maybe-exprs>.made,
        )
    }

    method expr:sym<paren-tail>($/) {
        make ExprParen.new(
            maybe-exprs =>  $<maybe-exprs>.made,
        )
    }

    method expr:sym<brack-tail>($/) {
        make ExprVec.new(
            vec-expr =>  $<vec-expr>.made,
        )
    }

    method expr:sym<continue>($/) {
        make ExprAgain.new(

        )
    }

    method expr:sym<continue-ident>($/) {
        make ExprAgain.new(
            ident =>  $<ident>.made,
        )
    }

    method expr:sym<return>($/) {
        make ExprRet.new(

        )
    }

    method expr:sym<return-expr>($/) {
        make ExprRet.new(
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<break>($/) {
        make ExprBreak.new(

        )
    }

    method expr:sym<break-ident>($/) {
        make ExprBreak.new(
            ident =>  $<ident>.made,
        )
    }

    method expr:sym<yield>($/) {
        make ExprYield.new(

        )
    }

    method expr:sym<yield-expr>($/) {
        make ExprYield.new(
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<expr-eq-expr>($/) {
        make ExprAssign.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<expr-shleq-expr>($/) {
        make ExprAssignShl.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<expr-shreq-expr>($/) {
        make ExprAssignShr.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<expr-minuseq-expr>($/) {
        make ExprAssignSub.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<expr-andeq-expr>($/) {
        make ExprAssignBitAnd.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<expr-oreq-expr>($/) {
        make ExprAssignBitOr.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<expr-pluseq-expr>($/) {
        make ExprAssignAdd.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<expr-stareq-expr>($/) {
        make ExprAssignMul.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<expr-slasheq-expr>($/) {
        make ExprAssignDiv.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<expr-careteq-expr>($/) {
        make ExprAssignBitXor.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<expr-percenteq-expr>($/) {
        make ExprAssignRem.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<expr-oror-expr>($/) {
        make ExprBinary.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<expr-andand-expr>($/) {
        make ExprBinary.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<expr-eqeq-expr>($/) {
        make ExprBinary.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<expr-ne-expr>($/) {
        make ExprBinary.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<expr-lt-expr>($/) {
        make ExprBinary.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<expr-gt-expr>($/) {
        make ExprBinary.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<expr-le-expr>($/) {
        make ExprBinary.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<expr-ge-expr>($/) {
        make ExprBinary.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<expr-pipe-expr>($/) {
        make ExprBinary.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<expr-caret-expr>($/) {
        make ExprBinary.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<expr-amp-expr>($/) {
        make ExprBinary.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<expr-shl-expr>($/) {
        make ExprBinary.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<expr-shr-expr>($/) {
        make ExprBinary.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<expr-plus-expr>($/) {
        make ExprBinary.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<expr-minus-expr>($/) {
        make ExprBinary.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<expr-star-expr>($/) {
        make ExprBinary.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<expr-slash-expr>($/) {
        make ExprBinary.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<expr-mod-expr>($/) {
        make ExprBinary.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<expr-dotdot>($/) {
        make ExprRange.new(
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<expr-dotdot-expr>($/) {
        make ExprRange.new(
            expr =>  $<expr>.made,
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<dotdot-expr>($/) {
        make ExprRange.new(
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<dotdot>($/) {
        make ExprRange.new(

        )
    }

    method expr:sym<expr-as-ty>($/) {
        make ExprCast.new(
            expr =>  $<expr>.made,
            ty   =>  $<ty>.made,
        )
    }

    method expr:sym<expr-ty>($/) {
        make ExprTypeAscr.new(
            expr =>  $<expr>.made,
            ty   =>  $<ty>.made,
        )
    }

    method expr:sym<box-expr>($/) {
        make ExprBox.new(
            expr =>  $<expr>.made,
        )
    }

    method expr:sym<expr-qualified-path>($/) {
        make $<expr-qualified-path>.made
    }

    method expr:sym<block-expr>($/) {
        make $<block-expr>.made
    }

    method expr:sym<block>($/) {
        make $<block>.made
    }

    method expr:sym<nonblock-prefix-expr>($/) {
        make $<nonblock-prefix-expr>.made
    }

=end comment
}

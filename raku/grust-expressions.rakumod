our role ExpressionWithBlock::Rules {

    rule expression-with-block {
        <outer-attribute>*
        <expression-with-block-item>
    }

    proto rule expression-with-block-item { * }
    rule expression-with-block-item:sym<block>        { <block-expression> }
    rule expression-with-block-item:sym<async-block>  { <async-block-expression> }
    rule expression-with-block-item:sym<unsafe-block> { <unsafe-block-expression> }
    rule expression-with-block-item:sym<loop>         { <loop-expression> }
    rule expression-with-block-item:sym<if>           { <if-expression> }
    rule expression-with-block-item:sym<if-let>       { <if-let-expression> }
    rule expression-with-block-item:sym<match>        { <match-expression> }
}

our role ExpressionWithoutBlock::Rules {

    rule expression-without-block {
        <outer-attribute>*
        <expression-without-block-item>
    }

    proto rule expression-without-block-item { * }
    token expression-without-block-item:sym<lit-char>         { <char-literal>            } 
    token expression-without-block-item:sym<lit-str>          { <string-literal>          } 
    token expression-without-block-item:sym<lit-raw-str>      { <raw-string-literal>      } 
    token expression-without-block-item:sym<lit-byte>         { <byte-literal>            } 
    token expression-without-block-item:sym<lit-byte-str>     { <byte-string-literal>     } 
    token expression-without-block-item:sym<lit-raw-byte-str> { <raw-byte-string-literal> } 
    token expression-without-block-item:sym<lit-int>          { <integer-literal>         } 
    token expression-without-block-item:sym<lit-float>        { <float-literal>           } 
    token expression-without-block-item:sym<lit-bool>         { <boolean-literal>         } 

    rule expression-without-block-item:sym<path-basic>        { <path-in-expression> }
    rule expression-without-block-item:sym<path-qualified>    { <qualified-path-in-expression> }

    rule expression-without-block-item:sym<borrow-ref>        { <tok-and> <kw-mut>? <expression> }
    rule expression-without-block-item:sym<borrow-refref>     { <tok-andand> <kw-mut>? <expression> }

    rule expression-without-block-item:sym<deref>             { <tok-star> <expression> } 
    rule expression-without-block-item:sym<error-propagation> { <expression> <tok-qmark> } 
    rule expression-without-block-item:sym<minus-expr>        { <tok-minus> <expression> } 
    rule expression-without-block-item:sym<bang-expr>         { <tok-bang> <expression> } 

    rule expression-without-block-item:sym<expr-plus-expr>    { <expression> <tok-plus>    <expression> } 
    rule expression-without-block-item:sym<expr-minus-expr>   { <expression> <tok-minus>   <expression> } 
    rule expression-without-block-item:sym<expr-star-expr>    { <expression> <tok-star>    <expression> } 
    rule expression-without-block-item:sym<expr-slash-expr>   { <expression> <tok-slash>   <expression> } 
    rule expression-without-block-item:sym<expr-percent-expr> { <expression> <tok-percent> <expression> } 
    rule expression-without-block-item:sym<expr-and-expr>     { <expression> <tok-and>     <expression> } 
    rule expression-without-block-item:sym<expr-or-expr>      { <expression> <tok-or>      <expression> } 
    rule expression-without-block-item:sym<expr-xor-expr>     { <expression> <tok-xor>     <expression> } 
    rule expression-without-block-item:sym<expr-lsh-expr>     { <expression> <tok-lshift>  <expression> } 
    rule expression-without-block-item:sym<expr-rsh-expr>     { <expression> <tok-rshift>  <expression> } 

    rule expression-without-block-item:sym<eq>                { <expression> <tok-eqeq> <expression> }
    rule expression-without-block-item:sym<ne>                { <expression> <tok-ne> <expression> }
    rule expression-without-block-item:sym<gt>                { <expression> <tok-gt> <expression> }
    rule expression-without-block-item:sym<lt>                { <expression> <tok-lt> <expression> }
    rule expression-without-block-item:sym<ge>                { <expression> <tok-ge> <expression> }
    rule expression-without-block-item:sym<le>                { <expression> <tok-le> <expression> }
    rule expression-without-block-item:sym<||>                { <expression> <tok-oror> <expression> }
    rule expression-without-block-item:sym<&&>                { <expression> <tok-andand> <expression> }
    rule expression-without-block-item:sym<type-cast>         { <expression> <kw-as> <type-no-bounds> }
    rule expression-without-block-item:sym<assign>            { <expression> <tok-eq> <expression> }
    rule expression-without-block-item:sym<+=>                { <expression> <tok-pluseq> <expression> }
    rule expression-without-block-item:sym<-=>                { <expression> <tok-minuseq> <expression> }
    rule expression-without-block-item:sym<*=>                { <expression> <tok-stareq> <expression> }
    rule expression-without-block-item:sym</=>                { <expression> <tok-diveq> <expression> }
    rule expression-without-block-item:sym<%=>                { <expression> <tok-percenteq> <expression> }
    rule expression-without-block-item:sym<&=>                { <expression> <tok-andeq> <expression> }
    rule expression-without-block-item:sym<|=>                { <expression> <tok-oreq> <expression> }
    rule expression-without-block-item:sym<^=>                { <expression> <tok-careteq> <expression> }
    rule expression-without-block-item:sym<shl-eq>            { <expression> <tok-shleq> <expression> }
    rule expression-without-block-item:sym<shr-eq>            { <expression> <tok-shreq> <expression> }
    rule expression-without-block-item:sym<grouped>           { <tok-lparen> <expression> <tok-rparen> }
    rule expression-without-block-item:sym<array>             { <tok-lbrack> <array-elements>? <tok-rbrack> }
    rule expression-without-block-item:sym<await>             { <expression> <tok-dot> <kw-await> }
    rule expression-without-block-item:sym<index>             { <expression> <tok-lbrack> <expression> <tok-rbrack> }

    rule expression-without-block-item:sym<tuple>             { <tok-lparen> <tuple-elements>? <tok-rparen> }
    rule expression-without-block-item:sym<tuple-indexing>    { <expression> <tok-dot> <tuple-index> }

    rule expression-without-block-item:sym<struct-expr-struct> { 
        <path-in-expression> 
        <tok-lbrace> 
        <struct-expr-struct-body>? 
        <tok-rbrace> 
    }

    rule expression-without-block-item:sym<struct-expr-tuple> { 
        <path-in-expression> 
        <tok-lparen> 
        [ <expression>* %% <tok-comma> ] 
        <tok-rparen>
    }

    rule expression-without-block-item:sym<struct-expr-unit> { <path-in-expression> }

    rule expression-without-block-item:sym<call> { 
        <expression> 
        <tok-lparen>
        <call-params>?
        <tok-rparen>
    } 

    rule expression-without-block-item:sym<method-call> { 
        <expression>
        <tok-dot>
        <path-expr-segment>
        <tok-lparen>
        <call-params>?
        <tok-rparen>
    } 

    rule expression-without-block-item:sym<field> { 
        <expression> 
        <tok-dot> 
        <identifier>
    } 

    rule expression-without-block-item:sym<closure> { 
        <kw-move>?
        <closure-expression-opener>
        <closure-body>
    } 

    rule expression-without-block-item:sym<continue> { 
        <kw-continue>
        <lifetime-or-label>?
    } 

    rule expression-without-block-item:sym<break> { 
        <kw-break> 
        <lifetime-or-label>?
        <expression>?
    } 

    rule expression-without-block-item:sym<range-expr>              { <expression> <tok-dotdot> <expression> }
    rule expression-without-block-item:sym<range-from-expr>         { <expression> <tok-dotdot> }
    rule expression-without-block-item:sym<range-to-expr>           { <tok-dotdot> <expression> }
    rule expression-without-block-item:sym<range-full>              { <tok-dotdot> }
    rule expression-without-block-item:sym<range-inclusive-expr>    { <expression> <tok-dotdoteq> <expression> }
    rule expression-without-block-item:sym<range-to-inclusive-expr> { <tok-dotdoteq> <expression> }
    rule expression-without-block-item:sym<return>                  { <kw-return> <expression>? } 

    rule expression-without-block-item:sym<macro> { 
        <simple-path> 
        <tok-bang> 
        <delim-token-tree>
    } 
}

our role Expression::Rules {

    proto rule expression { * }

    rule expression:sym<without-block> { <expression-without-block> }
    rule expression:sym<with-block>    { <expression-with-block> }
}

our role ExpressionWithoutBlock::Actions {}
our role ExpressionWithBlock::Actions {}
our role Expression::Actions {}

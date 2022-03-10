my $nostruct = False;
my $noblock  = False;

our role Expression::Rules {

    rule expression-nostruct { 
        {$nostruct = True}
        <expression>
        {$nostruct = False}
    }

    rule expression-noblock { 
        {$noblock = True}
        <expression>
        {$noblock = False}
    }

    rule expression { 
        <outer-attribute>* 
        <expression-item> 
        [ <tok-dotdoteq> <expression>                ]*
        [ <tok-dotdot>                               ]*
        [ <tok-dotdot>    <expression>               ]*
        [ <tok-dot>       <identifier>               ]*
        [ <tok-dot>       <path-expr-segment> <tok-lparen> <call-params>? <tok-rparen> ]*
        [ <tok-lparen>    <call-params>? <tok-rparen>]*
        [ <tok-dot>       <tuple-index>              ]*
        [ <tok-lbrack>    <expression> <tok-rbrack>  ]*
        [ <tok-dot>       <kw-await>                 ]*
        [ <tok-shreq>     <expression>               ]*
        [ <tok-shleq>     <expression>               ]*
        [ <tok-careteq>   <expression>               ]*
        [ <tok-oreq>      <expression>               ]*
        [ <tok-andeq>     <expression>               ]*
        [ <tok-percenteq> <expression>               ]*
        [ <tok-slasheq>   <expression>               ]*
        [ <tok-stareq>    <expression>               ]*
        [ <tok-minuseq>   <expression>               ]*
        [ <tok-pluseq>    <expression>               ]*
        [ <tok-eq>        <expression>               ]*
        [ <kw-as>         <type-no-bounds>           ]*
        [ <tok-andand>    <expression>               ]*
        [ <tok-oror>      <expression>               ]*
        [ <tok-le>        <expression>               ]*
        [ <tok-ge>        <expression>               ]*
        [ <tok-lt>        <expression>               ]*
        [ <tok-gt>        <expression>               ]*
        [ <tok-ne>        <expression>               ]*
        [ <tok-eqeq>      <expression>               ]*
        [ <tok-shr>       <expression>               ]*
        [ <tok-shl>       <expression>               ]*
        [ <tok-caret>     <expression>               ]*
        [ <tok-or>        <expression>               ]*
        [ <tok-and>       <expression>               ]*
        [ <tok-percent>   <expression>               ]*
        [ <tok-slash>     <expression>               ]*
        [ <tok-star>      <expression>               ]*
        [ <tok-minus>     <expression>               ]*
        [ <tok-plus>      <expression>               ]*
        <tok-qmark>* 
    }

    #-------------------------
    proto rule expression-item { * }
    token expression-item:sym<lit-char>         { <char-literal>            } 
    token expression-item:sym<lit-str>          { <string-literal>          } 
    token expression-item:sym<lit-raw-str>      { <raw-string-literal>      } 
    token expression-item:sym<lit-byte>         { <byte-literal>            } 
    token expression-item:sym<lit-byte-str>     { <byte-string-literal>     } 
    token expression-item:sym<lit-raw-byte-str> { <raw-byte-string-literal> } 
    token expression-item:sym<lit-int>          { <integer-literal>         } 
    token expression-item:sym<lit-float>        { <float-literal>           } 
    token expression-item:sym<lit-bool>         { <boolean-literal>         } 

    rule expression-item:sym<path-basic>        { <path-in-expression> }
    rule expression-item:sym<path-qualified>    { <qualified-path-in-expression> }

    rule expression-item:sym<borrow-ref>        { <tok-and> <kw-mut>? <expression> }
    rule expression-item:sym<borrow-refref>     { <tok-andand> <kw-mut>? <expression> }

    rule expression-item:sym<deref>             { <tok-star> <expression> } 
    rule expression-item:sym<minus-expr>        { <tok-minus> <expression> } 
    rule expression-item:sym<bang-expr>         { <tok-bang> <expression> } 

    rule expression-item:sym<grouped>           { <tok-lparen> <expression> <tok-rparen> }
    rule expression-item:sym<array>             { <tok-lbrack> <array-elements>? <tok-rbrack> }
    rule expression-item:sym<tuple>             { <tok-lparen> <tuple-elements>? <tok-rparen> }

    rule expression-item:sym<struct-expr-struct> { 
        <?{$nostruct eq False}>
        <path-in-expression> 
        <tok-lbrace> 
        <struct-expr-struct-body>? 
        <tok-rbrace> 
    }

    rule expression-item:sym<struct-expr-tuple> { 
        <?{$nostruct eq False}>
        <path-in-expression> 
        <tok-lparen> 
        [ <expression>* %% <tok-comma> ] 
        <tok-rparen>
    }

    rule expression-item:sym<struct-expr-unit> { 
        <?{$nostruct eq False}>
        <path-in-expression> 
    }

    rule expression-item:sym<closure> { 
        <kw-move>?
        <closure-expression-opener>
        <closure-body>
    } 

    rule expression-item:sym<continue> { 
        <kw-continue>
        <lifetime-or-label>?
    } 

    rule expression-item:sym<break> { 
        <kw-break> 
        <lifetime-or-label>?
        <expression>?
    } 

    rule expression-item:sym<range-to-expr>           { <tok-dotdot> <expression> }
    rule expression-item:sym<range-full>              { <tok-dotdot> }
    rule expression-item:sym<range-to-inclusive-expr> { <tok-dotdoteq> <expression> }
    rule expression-item:sym<return>                  { <kw-return> <expression>? } 

    rule expression-item:sym<macro> { 
        <simple-path> 
        <tok-bang> 
        <delim-token-tree>
    } 

    #------------------with block
    rule expression-item:sym<block>        { <?{$noblock eq False}> <expression-with-block> }

    proto rule expression-with-block { * }
    rule expression-with-block:sym<block>        { <block-expression> }
    rule expression-with-block:sym<async-block>  { <async-block-expression> }
    rule expression-with-block:sym<unsafe-block> { <unsafe-block-expression> }
    rule expression-with-block:sym<loop>         { <loop-expression> }
    rule expression-with-block:sym<if>           { <if-expression> }
    rule expression-with-block:sym<if-let>       { <if-let-expression> }
    rule expression-with-block:sym<match>        { <match-expression> }
}

our role Expression::Actions {}

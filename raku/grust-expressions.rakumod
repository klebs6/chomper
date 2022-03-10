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

    rule base-expression {
        <outer-attribute>* 
        <expression-item> 
    }

    #--------------------
    rule path-call-expression {
        <base-expression>
        [ 
            <tok-dot> 
            <path-expr-segment> 
            <tok-lparen> 
            <call-params>? 
            <tok-rparen> 
        ]*
    }

    rule call-expression {
        <path-call-expression>
        [ 
            <tok-lparen> 
            <call-params>? 
            <tok-rparen>
        ]*
    }

    #--------------------
    rule field-expression {
        <call-expression>
        [ <tok-dot> <identifier> ]*
    }

    rule await-expression {
        <field-expression>
        [ <tok-dot> <kw-await> ]*
    }

    #--------------------
    rule tuple-index-expression {
        <await-expression>
        [ <tok-dot> <tuple-index> ]*
    }

    rule index-expression {
        <tuple-index-expression>
        [ 
            <tok-lbrack> 
            <expression> 
            <tok-rbrack>  
        ]*
    }

    rule qmark-expression {
        <index-expression>
        <tok-qmark>* 
    }

    rule unary-bang-expression {
        <tok-bang>* <qmark-expression>
    }

    rule unary-minus-expression {
        <tok-minus>* <unary-bang-expression>
    }

    rule unary-star-expression {
        <tok-star>* <unary-minus-expression>
    }

    rule unary-ref-expression {
        [
            <tok-and> 
            <kw-mut>? 
        ]*
        <unary-star-expression>
    }

    rule unary-refref-expression {
        [
            <tok-and> 
            <tok-and> 
            <kw-mut>? 
        ]*
        <unary-ref-expression>
    }

    rule cast-expression {
        <unary-refref-expression>
        [ <kw-as> <type-no-bounds> ]*
    }

    #--------------------
    rule modulo-expression {
        <cast-expression>+ %% <tok-percent>
    }

    rule division-expression {
        <modulo-expression>+ %% <tok-slash>
    }

    rule multiplicative-expression {
        <division-expression>+ %% <tok-star>
    }

    rule subtractive-expression {
        <multiplicative-expression>+ %% <tok-minus>
    }

    rule additive-expression {
        <subtractive-expression>+ %% <tok-plus>
    }

    rule binary-shr-expression {
        <additive-expression>+ %% <tok-shr>
    }

    rule binary-shl-expression {
        <binary-shr-expression>+ %% <tok-shl>
    }

    #--------------------
    rule binary-and-expression {
        [<binary-shl-expression>+ %% <tok-and>]
    }

    rule binary-xor-expression {
        [<binary-and-expression>+ %% <tok-caret>]
    }

    rule binary-or-expression {
        [<binary-xor-expression>+ %% <tok-or>]
    }

    #--------------------
    rule binary-le-expression {
        <binary-or-expression>+ %% <tok-le>
    }

    rule binary-ge-expression {
        <binary-le-expression>+ %% <tok-ge>
    }

    rule binary-lt-expression {
        <binary-ge-expression>+ %% <tok-lt>
    }

    rule binary-gt-expression {
        <binary-lt-expression>+ %% <tok-gt>
    }

    rule binary-ne-expression {
        <binary-gt-expression>+ %% <tok-ne>
    }

    rule binary-eqeq-expression {
        <binary-ne-expression>+ %% <tok-eqeq>
    }

    rule binary-andand-expression {
        <binary-eqeq-expression>+ %% <tok-andand>
    }

    rule binary-oror-expression {
        <binary-andand-expression>+ %% <tok-oror>
    }

    #--------------------
    rule rangeto-eq-expression {
        <binary-oror-expression>+ %% <tok-dotdoteq>
    }

    rule range-open-expression {
        <rangeto-eq-expression>+ % <tok-dotdot>
    }

    rule range-to-expression {
        <range-open-expression> [ <tok-dotdot> <range-open-expression> ]*
    }

    #--------------------

    rule shreq-expression {
        <range-to-expression>+ %% <tok-shreq>
    }

    rule shleq-expression {
        <shreq-expression>+ %% <tok-shleq>
    }

    rule xoreq-expression {
        <shleq-expression>+ %% <tok-careteq>
    }

    rule oreq-expression {
        <xoreq-expression>+ %% <tok-oreq>
    }

    rule andeq-expression {
        <oreq-expression>+ %% <tok-andeq>
    }

    rule modeq-expression {
        <andeq-expression>+ %% <tok-percenteq>
    }

    rule slasheq-expression {
        <modeq-expression>+ %% <tok-slasheq>
    }

    rule stareq-expression {
        <slasheq-expression>+ %% <tok-stareq>
    }

    rule minuseq-expression {
        <stareq-expression>+ %% <tok-minuseq>
    }

    rule addeq-expression {
        <minuseq-expression>+ %% <tok-pluseq>
    }

    rule assign-expression {
        <addeq-expression>+ %% <tok-eq>
    }

    rule expression {
        <assign-expression>
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

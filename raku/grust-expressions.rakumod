
our role Expression::Rules {

    rule expression-nostruct { 
        {$*NOSTRUCT = True}
        <expression>
        {$*NOSTRUCT = False}
    }

    rule expression-noblock { 
        {$*NOBLOCK = True}
        <expression>
        {$*NOBLOCK = False}
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

    rule call-params {
        <expression>+ %% <tok-comma>
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

    rule error-propagation-expression {
        <index-expression>
        <tok-qmark>* 
    }

    rule unary-bang-expression {
        <tok-bang>* 
        <error-propagation-expression>
    }

    rule unary-minus-expression {
        <tok-minus>* 
        <unary-bang-expression>
    }

    rule unary-star-expression {
        <tok-star>* 
        <unary-minus-expression>
    }

    rule borrow-expression {
        [
            <tok-and> 
            <tok-and>?
            <kw-mut>? 
        ]*
        <unary-star-expression>
    }

    rule cast-expression {
        <borrow-expression>
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
    proto rule range-expression { * }

    rule range-expression:sym<full> {  
        <binary-oror-expression> [<tok-dotdot>  <binary-oror-expression>]*
    }

    rule range-expression:sym<to> {  
        <tok-dotdot> 
        <binary-oror-expression>
    }

    rule range-expression:sym<from> {  
        <binary-oror-expression>
        <tok-dotdot> 
    }

    rule range-expression:sym<open> {  <tok-dotdot> }

    #--------------------

    rule shreq-expression {
        <range-expression>+ %% <tok-shreq>
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

    rule expression-item:sym<literal>  { <literal-expression> } 
    rule expression-item:sym<path>     { <path-expression>    }
    rule expression-item:sym<grouped>  { <tok-lparen> <expression> <tok-rparen> }
    rule expression-item:sym<array>    { <array-expression>   }
    rule expression-item:sym<tuple>    { <tuple-expression>   }
    rule expression-item:sym<struct>   { <?{$*NOSTRUCT eq False}> <struct-expression> }
    rule expression-item:sym<closure>  { <closure-expression> } 
    rule expression-item:sym<continue> { <continue-expression> } 
    rule expression-item:sym<break>    { <break-expression> } 
    rule expression-item:sym<return>   { <return-expression> } 
    rule expression-item:sym<macro>    { <macro-expression> } 
    rule expression-item:sym<block>    { <?{$*NOBLOCK eq False}> <expression-with-block> }

    #-------------------------
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

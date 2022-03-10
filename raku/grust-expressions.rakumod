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
    rule expression-without-block-item:sym<lit>            { <literal-expression>          } 
    rule expression-without-block-item:sym<path>           { <path-expression>             } 
    rule expression-without-block-item:sym<operator>       { <operator-expression>         } 
    rule expression-without-block-item:sym<grouped>        { <grouped-expression>          } 
    rule expression-without-block-item:sym<array>          { <array-expression>            } 
    rule expression-without-block-item:sym<await>          { <await-expression>            } 
    rule expression-without-block-item:sym<index>          { <index-expression>            } 
    rule expression-without-block-item:sym<tuple>          { <tuple-expression>            } 
    rule expression-without-block-item:sym<tuple-indexing> { <tuple-indexing-expression>   } 
    rule expression-without-block-item:sym<struct>         { <struct-expression>           } 
    rule expression-without-block-item:sym<call>           { <call-expression>             } 
    rule expression-without-block-item:sym<method-call>    { <method-call-expression>      } 
    rule expression-without-block-item:sym<field>          { <field-expression>            } 
    rule expression-without-block-item:sym<closure>        { <closure-expression>          } 
    rule expression-without-block-item:sym<continue>       { <continue-expression>         } 
    rule expression-without-block-item:sym<break>          { <break-expression>            } 
    rule expression-without-block-item:sym<range>          { <range-expression>            } 
    rule expression-without-block-item:sym<return>         { <return-expression>           } 
    rule expression-without-block-item:sym<macro>          { <macro-invocation-expression> } 
}

our role Expression::Rules {

    proto rule expression { * }

    rule expression:sym<without-block> { <expression-without-block> }
    rule expression:sym<with-block>    { <expression-with-block> }
}

our role ExpressionWithoutBlock::Actions {}
our role ExpressionWithBlock::Actions {}
our role Expression::Actions {}

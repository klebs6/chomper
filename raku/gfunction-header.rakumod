our role FreestandingTemplateFunction {
    rule freestanding-template-function-header() {
        <line-comment>*
        <api-tag>? 
        <template> '<' <template-args> '>'
        <inline>?
        <static>?
        <inline>? 
        <constexpr>?
        <return-type> 
        <function-name> 
        '(' <args> ')' <const>? 
        <noexcept>? 
        <override>?
    }
}

our role OpMulEq {
    rule op-mul-eq-function-header {
        <line-comment>* 
        <api-tag>?
        <friend>?
        <inline>?
        <return-type>
        <namespace>?
        'operator' '*=' '(' <args> ')'
    }

}

our role OpDivEq {
    rule op-div-eq-function-header {
        <line-comment>* 
        <api-tag>?
        <friend>?
        <inline>?
        <return-type>
        <namespace>?
        'operator' '/=' '(' <args> ')'
    }
}

our role OpIndexFunction {
    rule op-index-function-header {
        <line-comment>* 
        <api-tag>?
        <friend>?
        <inline>?
        <return-type>
        <namespace>?
        'operator' '[]' '(' <args> ')'
        <const>?
    }
}

our role OpAddEq {
    rule op-add-eq-function-header {
        <line-comment>* 
        <api-tag>?
        <friend>?
        <inline>?
        <return-type>
        <namespace>?
        'operator' '+=' '(' <args> ')'
    }
}

our role OpBitorAssign {
    rule op-bitor-assign-function-header {
        <line-comment>* 
        <api-tag>?
        <friend>?
        <inline>?
        <return-type>
        <namespace>?
        'operator' '|=' '(' <args> ')'
    }
}

our role OpBitandAssign {
    rule op-bitand-assign-function-header {
        <line-comment>* 
        <api-tag>?
        <friend>?
        <inline>?
        <return-type>
        <namespace>?
        'operator' '&=' '(' <args> ')'
    }
}

our role OpSubEq {
    rule op-sub-eq-function-header {
        <line-comment>* 
        <api-tag>?
        <friend>?
        <inline>?
        <return-type>
        <namespace>?
        'operator' '-=' '(' <args> ')'
    }
}

our role OpNegate {
    rule op-negate-function-header {
        <line-comment>* 
        <api-tag>?
        <friend>?
        <inline>?
        <return-type>
        <namespace>?
        'operator' '-' '(' ')'
        <const>?
    }
}

our role OpAdd {
    rule op-add-function-header {
        <line-comment>* 
        <api-tag>?
        <friend>?
        <inline>?
        <return-type>
        <namespace>?
        'operator' '+' '(' <args> ')'
        <const>?
    }
}

our role OpIntoBool {
    rule operator-into-bool {
        <line-comment>* 
        <api-tag>?
        <friend>?
        <inline>?
        <explicit>?
        'operator'
        <return-type>
        '(' ')'
        <const>?
    }
}

our role OpNot {
    rule operator-not {
        <line-comment>* 
        <api-tag>?
        <friend>?
        <inline>?
        <explicit>?
        <return-type>
        'operator'
        '!'
        '(' ')'
        <const>?
    }
}

our role OpIndirect {
    rule operator-indirect {
        <line-comment>* 
        <api-tag>?
        <friend>?
        <inline>?
        <explicit>?
        <return-type>
        'operator'
        '->'
        '(' ')'
        <const>?
    }
}

our role OpMul {
    rule op-mul-function-header {
        <line-comment>* 
        <api-tag>?
        <friend>?
        <inline>?
        <return-type>
        <namespace>?
        'operator' '*' '(' <args> ')'
        <const>?
    }
}

our role OpXor {
    rule op-xor-function-header {
        <line-comment>* 
        <api-tag>?
        <friend>?
        <inline>?
        <return-type>
        <namespace>?
        'operator' '^' '(' <args> ')'
        <const>?
    }
}

our role OpBitand {
    rule op-bitand-function-header {
        <line-comment>* 
        <api-tag>?
        <friend>?
        <inline>?
        <return-type>
        <namespace>?
        'operator' '&' '(' <args> ')'
        <const>?
    }
}

our role OpBitor {
    rule op-bitor-function-header {
        <line-comment>* 
        <api-tag>?
        <friend>?
        <inline>?
        <return-type>
        <namespace>?
        'operator' '|' '(' <args> ')'
        <const>?
    }
}

our role OpConvert {
    rule op-convert-function-header {
        <line-comment>* 
        <api-tag>?
        <inline>?
        'operator' <type> '(' <args> ')'
        <const>?
    }
}

our role OpDiv {
    rule op-div-function-header {
        <line-comment>* 
        <api-tag>?
        <friend>?
        <inline>?
        <return-type>
        <namespace>?
        'operator' '/' '(' <args> ')'
        <const>?
    }
}

our role OpSub {

    rule op-sub-function-header {
        <line-comment>* 
        <api-tag>?
        <friend>?
        <inline>?
        <return-type>
        <namespace>?
        'operator' '-' '(' <args> ')'
        <const>?
    }
}

our role OpEq {
    rule op-eq-function-header {
        <line-comment>* 
        <api-tag>?
        <friend>?
        <inline>?
        'bool'
        <namespace>?
        'operator' '==' '(' <args> ')'
        <const>?
    }
}

our role OpLt {

    rule op-lt-function-header {
        <line-comment>* 
        <api-tag>?
        <friend>?
        <inline>?
        'bool'
        <namespace>?
        'operator' '<' '(' <args> ')'
        <const>?
    }
}

our role OpOstream {

    rule op-ostream-function-header {
        <line-comment>* 
        <inline>?
        ['std::']? 'ostream' '&'
        'operator' '<<' '(' <args> ')'
    }
}

#---------------------------------
our role OpShlAssign {
    rule op-shl-assign-function-header {
        <line-comment>* 
        <api-tag>?
        <friend>?
        <inline>?
        <return-type>
        <namespace>?
        'operator' '<<=' '(' <args> ')'
    }
}

our role OpShl {
    rule op-shl-function-header {
        <line-comment>* 
        <api-tag>?
        <friend>?
        <inline>?
        <return-type>
        <namespace>?
        'operator' '<<' '(' <args> ')'
        <const>?
    }
}

our role OpShrAssign {
    rule op-shr-assign-function-header {
        <line-comment>* 
        <api-tag>?
        <friend>?
        <inline>?
        <return-type>
        <namespace>?
        'operator' '>>=' '(' <args> ')'
    }
}

our role OpShr {
    rule op-shr-function-header {
        <line-comment>* 
        <api-tag>?
        <friend>?
        <inline>?
        <return-type>
        <namespace>?
        'operator' '>>' '(' <args> ')'
        <const>?
    }
}

our role FunctionHeader 
does FreestandingTemplateFunction 
does OpMulEq
does OpMul
does OpDivEq
does OpIndexFunction
does OpBitorAssign
does OpBitor
does OpBitandAssign
does OpSubEq
does OpNegate
does OpAdd
does OpAddEq
does OpXor
does OpBitand
does OpConvert
does OpDiv
does OpSub
does OpEq
does OpLt
does OpOstream
does OpIntoBool
does OpIndirect
does OpNot
does OpShl
does OpShr
does OpShlAssign
does OpShrAssign
{

}

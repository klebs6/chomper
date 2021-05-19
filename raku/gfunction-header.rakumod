our role FunctionHeader {

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

    rule op-mul-eq-function-header {
        <line-comment>* 
        <api-tag>?
        <friend>?
        <inline>?
        <return-type>
        <namespace>?
        'operator' '*=' '(' <args> ')'
    }

    rule op-div-eq-function-header {
        <line-comment>* 
        <api-tag>?
        <friend>?
        <inline>?
        <return-type>
        <namespace>?
        'operator' '/=' '(' <args> ')'
    }

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

    rule op-add-eq-function-header {
        <line-comment>* 
        <api-tag>?
        <friend>?
        <inline>?
        <return-type>
        <namespace>?
        'operator' '+=' '(' <args> ')'
    }

    rule op-bitor-assign-function-header {
        <line-comment>* 
        <api-tag>?
        <friend>?
        <inline>?
        <return-type>
        <namespace>?
        'operator' '|=' '(' <args> ')'
    }

    rule op-bitand-assign-function-header {
        <line-comment>* 
        <api-tag>?
        <friend>?
        <inline>?
        <return-type>
        <namespace>?
        'operator' '&=' '(' <args> ')'
    }

    rule op-sub-eq-function-header {
        <line-comment>* 
        <api-tag>?
        <friend>?
        <inline>?
        <return-type>
        <namespace>?
        'operator' '-=' '(' <args> ')'
    }

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

    rule op-convert-function-header {
        <line-comment>* 
        <api-tag>?
        <inline>?
        'operator' <type> '(' <args> ')'
        <const>?
    }

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

    rule op-ostream-function-header {
        <line-comment>* 
        ['std::']? 'ostream' '&'
        'operator' '<<' '(' <args> ')'
    }
}

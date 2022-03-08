our role Function::Rules {

    rule function {
        <function-qualifiers>
        <kw-fn>
        <identifier>
        <generic-params>?
        <tok-lparen>
        <function-parameters>?
        <tok-rparen>
        <function-return-type>?
        <where-clause>?
        [
            | <block-expression>
            | <tok-semi>
        ]
    }

    rule function-qualifiers {
        <kw-const>?
        <kw-async>?
        <kw-unsafe>?
        [ <kw-extern> <abi>? ]?
    }

    proto rule abi { * }

    rule abi:sym<str>     { <string-literal> }

    rule abi:sym<raw-str> { <raw-string-literal> }

    #----------------------
    proto rule function-parameters { * }

    rule function-parameters:sym<just-self> {
        <self-param> <tok-comma>?
    }

    rule function-parameters:sym<just-params> {
        <function-param>+ %% <tok-comma>
    }

    rule function-parameters:sym<self-and-just-params> {
        <self-param> 
        <tok-comma>
        [ <function-param>+ %% <tok-comma> ]
    }

    #----------------------
    rule self-param {  
        <outer-attribute>*
        <self-param-variant>
    }

    proto rule self-param-variant { * }

    rule self-param-variant:sym<shorthand> { <shorthand-self> }
    rule self-param-variant:sym<typed>     { <typed-self> }

    #----------------------
    rule shorthand-self {
        [
            <tok-ref> <lifetime>?
        ]?
        <kw-mut>?
        <kw-self>
    }

    rule typed-self {
        <kw-mut>?
        <kw-self>
        <tok-colon>
        <type>
    }

    #-------------------
    rule function-param {
        <outer-attribute>*
        <function-param-variant>
    }

    proto rule function-param-variant { * }

    rule function-param-variant:sym<pattern> {
        <function-param-pattern>
    }

    rule function-param-variant:sym<ellipsis> {
        <tok-ellipsis>
    }

    rule function-param-variant:sym<type> {
        <type>
    }

    #-------------------
    rule function-param-pattern {
        <pattern-no-top-alt> 
        <tok-colon>
        <function-param-pattern-variant>
    }

    proto rule function-param-pattern-variant { * }
    rule function-param-pattern-variant:sym<type>     { <type> }
    rule function-param-pattern-variant:sym<ellipsis> { <tok-ellipsis> }

    rule function-return-type {
        <tok-rarrow>
        <type>
    }
}

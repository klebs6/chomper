our role BareFunctionType::Rules {

    rule bare-function-type {
        <for-lifetimes>?
        <function-type-qualifiers>
        <kw-fn>
        <tok-lparen>
        <function-parameters-maybe-named-variadic>?
        <tok-rparen>
        <bare-function-return-type>?
    }

    rule function-type-qualifiers {
        <kw-unsafe>?
        [
            <kw-extern>
            <abi>?
        ]?
    }

    rule bare-function-return-type {
        <tok-rarrow>
        <type-no-bounds>
    }

    #-------------------
    proto rule function-parameters-maybe-named-variadic { * }

    rule function-parameters-maybe-named-variadic:sym<basic> {  
        <maybe-named-function-parameters>
    }

    rule function-parameters-maybe-named-variadic:sym<variadic> {  
        <maybe-named-function-parameters-variadic>
    }

    rule maybe-named-function-parameters {
        <maybe-named-param>+ %% <tok-comma>
    }

    rule maybe-named-param {
        <outer-attribute>*
        [
            <identifier-or-underscore>
            <tok-colon>
        ]?
        <type>
    }

    rule maybe-named-function-parameters-variadic {
        [<maybe-named-param>+ % <tok-comma>]
        <outer-attribute>*
        <tok-dotdotdot>
    }
}

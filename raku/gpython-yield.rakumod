
our role Python3YieldExpr {

    token yield_expr {
        <YIELD> <yield_arg>?
    }

    token yield_arg {
        | <FROM> <test>
        | <testlist>
    }
}

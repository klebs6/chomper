
our role Python3Test {

    token lambdef {
        <LAMBDA> <varargslist>? ':' <test>
    }

    token lambdef_nocond {
        <LAMBDA> <varargslist>? ':' <test_nocond>
    }

    token test {
        | <or_test> [ <IF> <or_test> <ELSE> <test> ]?
        | <lambdef>
    }

    token testlist_star_expr {
        [ <test> | <star_expr> ]+ %% ","
    }

    token test_nocond {
        | <or_test>
        | <lambdef_nocond>
    }

    token or_test {
        <and_test>+ %% <OR>
    }

    token and_test {
        <not_test>+ %% <AND>
    }

    token not_test {
        <NOT>* 
        <comparison>
    }

    token subscript {
        | <test>
        | <test>?  ':' <test>?  <sliceop>?
    }

    token sliceop {
        ':' <test>?
    }

    token testlist {
        <test>+ %% "," 
    }

    token testlist_comp {
        <test>
        [ 
            | <comp_for>
            | [ ',' <test>]* ','?
        ]
    }

    token comp_iter {
        | <comp_for>
        | <comp_if>
    }

    token comp_for {
        <FOR> <exprlist> <IN> <or_test> <comp_iter>?
    }

    token comp_if {
        <IF> <test_nocond> <comp_iter>?
    }
}

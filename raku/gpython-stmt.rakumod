
our role Python3Stmt {

    token stmt {
        | <simple_stmt>
        | <compound_stmt>
    }

    token simple_stmt {
        <small_stmt>+ %% ";"
        <NEWLINE>
    }

    token small_stmt {
        | <expr_stmt>
        | <del_stmt>
        | <pass_stmt>
        | <flow_stmt>
        | <import_stmt>
        | <global_stmt>
        | <nonlocal_stmt>
        | <assert_stmt>
    }

    token expr_stmt {
        <testlist_star_expr>
        [   
            | <augassign> [ <yield_expr> | <testlist> ]
            | [ '=' [ <yield_expr> | <testlist_star_expr>]]*
        ]
    }

    token del_stmt  { <DEL> <exprlist> }
    token pass_stmt { <PASS> }

    token flow_stmt {
        | <break_stmt>
        | <continue_stmt>
        | <return_stmt>
        | <raise_stmt>
        | <yield_stmt>
    }

    token break_stmt    { <BREAK> }
    token continue_stmt { <CONTINUE> }

    token return_stmt   { <RETURN> <testlist>?  }
    token yield_stmt    { <yield_expr> }

    token raise_stmt {
        <RAISE> [ <test> [ <FROM> <test> ]? ]?
    }

    token global_stmt {
        <GLOBAL> <NAME> [ ',' <NAME> ]*
    }

    token nonlocal_stmt {
        <NONLOCAL> <NAME> [ ',' <NAME> ]*
    }

    token assert_stmt {
        <ASSERT> <test> [ ',' <test> ]?
    }

    token compound_stmt {
        | <if_stmt>
        | <while_stmt>
        | <for_stmt>
        | <try_stmt>
        | <with_stmt>
        | <funcdef>
        | <classdef>
        | <decorated>
    }

    token funcdef {
        <DEF>
        <NAME>
        <parameters>
        [    
            | '->' <test>
        ]?
        ':'
        <suite>
    }

    token classdef {
        <CLASS>
        <NAME>
        [ '(' <arglist>?  ')' ]?
        ':'
        <suite>
    }

    token if_stmt {

        <IF> <test> ':' <suite>

        [ <ELIF> <test> ':' <suite> ]*
        [ <ELSE> ':' <suite> ]?
    }

    token while_stmt {
        <WHILE> <test> ':' <suite>
        [ <ELSE> ':' <suite>]?
    }

    token for_stmt {
        <FOR> <exprlist> <IN> <testlist> ':' <suite>
        [ <ELSE> ':' <suite> ]?
    }

    token try_stmt {
        <TRY> ':' <suite>
        [   
            | [ <except_clause> ':' <suite>]+ [ <ELSE> ':' <suite> ]? [ <FINALLY> ':' <suite> ]?
            | <FINALLY> ':' <suite>
        ]
    }

    token except_clause {
        <EXCEPT> [ <test> [ <AS> <NAME>]? ]?
    }

    token with_item {
        <test> [ <AS> <expr> ]?
    }

    token with_stmt {
        <WITH> [ <with_item>+ %% "," ] ':' <suite>
    }
}

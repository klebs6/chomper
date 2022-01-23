
our role Python3Expr {

    token comparison {
        <star_expr> [ <comp_op> <star_expr> ]*
    }

    token comp_op {
        | '<'
        | '>'
        | '=='
        | '>='
        | '<='
        | '<>'
        | '!='
        | <IN>
        | <NOT> <IN>
        | <IS>
        | <IS> <NOT>
    }

    token star_expr {
        '*'?  <expr>
    }

    token expr {
        <xor_expr>+ %% '|'
    }

    token xor_expr {
        <and_expr>+ %% '^'
    }

    token and_expr {
        <shift_expr>+ %% '&'
    }

    token shift-operator {
        | '<<'
        | '>>'
    }

    token shift_expr {
        <arith_expr>+ %% <shift-operator>
    }

    token arith-operator {
        | '+'
        | '-'
    }

    token arith_expr {
        <term>+ %% <arith-operator>
    }

    token factor-operator {
        | '*'  
        | '/'  
        | '%'  
        | '//' 
        | '@'  
    }

    token term {
        <factor>+ %% <factor-operator>
    }

    token factor {
        [ '+' | '-' | '~' ]*
         <power>
    }

    token power {
        <atom> <trailer>* [ '**' <factor> ]?
    }

    token trailer {
        | '(' <arglist>?  ')'
        | '[' <subscriptlist> '\]'
        | '.' <NAME>
    }

    token subscriptlist {
        <subscript> [ ',' <subscript>]* ','?
    }

    token exprlist {
        <star_expr>+ %% ","
    }

    token atom {
        | '(' [ <yield_expr> | <testlist_comp>]?  ')'
        | '[' <testlist_comp>?  '\]'
        | '{' <dictorsetmaker>?  '}'
        | <NAME>
        | <number>
        | <string>+
        | '...'
        | <NONE>
        | <TRUE>
        | <FALSE>
    }
}

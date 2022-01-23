
our role Python3Arg {

    token arglist {
        [ <argument> ',']*
        [   
            | <argument> ','?
            | '*' <test> [ ',' <argument>]* [ ',' '**' <test>]?
            | '**' <test>
        ]
    }

    token argument {
        | <test> <comp_for>?
        | <test> '=' <test>
    }
}


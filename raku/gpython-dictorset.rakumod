
our role Python3DictOrSet {

    token dictorsetmaker-a {
        <test> ':'
        <test>
        [    
            | <comp_for>
            | [ ',' <test> ':' <test>]* ','?
        ]
    }

    token dictorsetmaker-b {
        <test>
        [    
            | <comp_for>
            | [ ',' <test>]* ','?
        ]
    }

    token dictorsetmaker {
        | <dictorsetmaker-a>
        | <dictorsetmaker-b>
    }
}


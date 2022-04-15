our role SimpleIfdef {

    token ifdef  { '#ifdef' | '#if' }
    token ifndef { '#ifndef' }

    rule ifdef-logical {
        | <identifier>
        | <ifdef-logical-binary-and>
        | <ifdef-logical-binary-or>
    }

    rule ifdef-expression { <ifdef-term> + % <ifdef-infix> }

    #----------------------------------
    proto token ifdef-infix   { * }
    token ifdef-infix:sym<||>  { <sym> }
    token ifdef-infix:sym<&&>  { <sym> }

    #----------------------------------
    proto token ifdef-term { * }
    token ifdef-term:sym<identifier> {
        <identifier>
    }

    rule ifdef-term:sym<parenthesized> {
        '(' ~ ')' <ifdef-expression>
    }

    rule ifdef-term:sym<negated-term> {
        '!' <ifdef-term>
    }

    rule simple-ifdef {
        [<ifdef> | <ifndef>] <ifdef-expression>
    }
}

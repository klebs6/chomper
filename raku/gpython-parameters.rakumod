our role Python3Parameters {

    token parameters {
        '(' <typedargslist>?  ')'
    }

    token tfpdef {
         <NAME> [ ':' <test> ]?
    }

    token maybe-equals-test {
        [ '=' <test>]?
    }

    token typedargslist-args {
        '*' <tfpdef>?  
        [ ',' <tfpdef> <maybe-equals-test> ]* 
        [ ',' '**' <tfpdef> ]?
    }

    token typedargslist-kwargs {
        '**' <tfpdef>
    }

    token typedargslist-full {
        <tfpdef>
        <maybe-equals-test> 
        [ ',' <tfpdef> <maybe-equals-test> ]*
        [ ','
            [   
                | <typedargslist-args>
                | <typedargslist-kwargs>
            ]?
        ]?
    }

    token typedargslist {
        | <typedargslist-full>
        | <typedargslist-args>
        | <typedargslist-kwargs>
    }

}

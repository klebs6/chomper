
our role Python3VarArgs {

    token vfpdef {
        <NAME>
    }

    token varargslist-star {
        '*' <vfpdef>?  
        [ ',' <vfpdef> <maybe-equals-test> ]* 
        [ ',' '**' <vfpdef> ]?
    }

    token varargslist-star-star {
        '**' <vfpdef>
    }

    token varargslist-full {
        <vfpdef> <maybe-equals-test> 
        [ ',' <vfpdef> <maybe-equals-test> ]*
        [ ','
            [   
                | <varargslist-star> 
                | <varargslist-star-star>
            ]?
        ]?
    }

    token varargslist {
        | <varargslist-full>
        | <varargslist-star>
        | <varargslist-star-star>
    }
}

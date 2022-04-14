
our role Python3::Grammar::VarArgsList {

    proto rule varargslist { * }

    rule vfpdef-maybe-test {
        <vfpdef> [ '=' <test> ]?
    }

    rule varargslist-basic {
        <vfpdef-maybe-test> 
        [ <COMMA> <vfpdef-maybe-test> ]*
    }

    rule varargslist-star-args {
        '*' <vfpdef>? [ <COMMA> <vfpdef-maybe-test> ]*
    }

    rule varargslist-kwargs {
        '**' <vfpdef>
    }

    rule varargslist:sym<full> {
        <varargslist-basic>
        <COMMA>
        <varargslist-star-args>
        <COMMA> 
        <varargslist-kwargs>
    }

    rule varargslist:sym<just-basic> {
        <varargslist-basic>
        <COMMA>?
    }

    rule varargslist:sym<just-star-args> {
        <varargslist-star-args>
    }

    rule varargslist:sym<just-kwargs> {
        <varargslist-kwargs>
    }

    rule varargslist:sym<basic-and-star-args> {
        <varargslist-basic>
        <COMMA>
        <varargslist-star-args>
    }

    rule varargslist:sym<basic-and-kwargs> {
        <varargslist-basic>
        <COMMA>
        <varargslist-kwargs>
    }

    rule varargslist:sym<star-and-kwargs> {
        <varargslist-star-args>
        <COMMA> <varargslist-kwargs>
    }

    token vfpdef {
        <NAME>
    }
}

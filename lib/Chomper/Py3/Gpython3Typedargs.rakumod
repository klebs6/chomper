
our role Python3::Grammar::TypedArgList {

    regex parenthesized-typedarglist {
        <OPEN_PAREN> <typedargslist>?  <CLOSE_PAREN>
    }

    proto rule typedargslist { * }

    rule augmented-tfpdef {
        <tfpdef> [ '=' <test> ]?
    }

    rule augmented-tfpdef-comma-maybe-comment {
        <augmented-tfpdef> <COMMA> <COMMENT>* 
    }

    rule just-basic-args {
        <augmented-tfpdef-comma-maybe-comment>*
        <augmented-tfpdef> <comma-maybe-comment>?
    }

    rule star-args {
        '*' <tfpdef>?  [ <COMMA> <augmented-tfpdef> ]*
    }

    rule typedargslist-kwargs {
        '**' <tfpdef>
    }

    rule typedargslist:sym<full> {
        <just-basic-args>
        <star-args> 
        <COMMA> <typedargslist-kwargs>
    }

    rule typedargslist:sym<star-and-kwargs> {
        <star-args>
        <COMMA> <typedargslist-kwargs>
    }

    rule typedargslist:sym<basic-and-kwargs> {
        <just-basic-args>
        <typedargslist-kwargs>
    }

    rule typedargslist:sym<basic-and-star-args> {
        <just-basic-args>
        <star-args> 
    }

    rule typedargslist:sym<just-basic>     { <just-basic-args> }
    rule typedargslist:sym<just-star-args> { <star-args> }
    rule typedargslist:sym<just-kwargs>    { <typedargslist-kwargs> }

    #---------------------------------------
    rule tfpdef {
        <NAME> [ <COLON> <test> ]?
    }
}

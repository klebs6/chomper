
our role Python3Decorators {

    token decorator {
        '@'
        <dotted_name>
        [ 
            '(' <arglist>? ')' 
        ]?
        <NEWLINE>
    }

    token decorators {
        <decorator>+
    }

    token decorated {
        <decorators>
        [ 
            | <classdef>
            | <funcdef>
        ]
    }
}

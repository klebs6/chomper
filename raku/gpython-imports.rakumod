
our role Python3Imports {

    token import_stmt {
        | <import_name>
        | <import_from>
    }

    token import_name {
        <IMPORT> <dotted_as_names>
    }

    token import_from {
        <FROM>
        [   
            | [ '.'  | '...' ]* <dotted_name>
            | [ '.' | '...']+
        ]
        <IMPORT>
        [    
            | '*'
            | '(' <import_as_names> ')'
            | <import_as_names>
        ]
    }

    token import_as_name {
        <NAME> [ <AS> <NAME>]?
    }

    token dotted_as_name {
        <dotted_name> [ <AS> <NAME> ]?
    }

    token import_as_names {
        <import_as_name> [ ',' <import_as_name> ]* ','?
    }

    token dotted_as_names {
        <dotted_as_name> [ ',' <dotted_as_name> ]*
    }
}



our role Python3Input {

    token single_input {
        [
            | <NEWLINE>
            | <simple_stmt>
            | <compound_stmt>
        ]
        <NEWLINE>
    }

    token file_input {
        [  
            | <NEWLINE> 
            | <stmt> 
        ]* $
    }

    token eval_input {
        <testlist> <NEWLINE>* $
    }
}

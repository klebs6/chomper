our role LineComment::Rules {

    token line-comment-begin {
        || \/\/\/
        || \/\/
    }

    token line-comment-body {
        <-[ \r \n ]>* 
    }

    token line-comment {
        <.ws> 
        <.line-comment-begin> 
        <line-comment-body>
    }
}

our role LineComment::Actions {

    method line-comment($/) {
        make $<line-comment-body>.made
    }

    method line-comment-body($/) {
        make ~$/
    }
}

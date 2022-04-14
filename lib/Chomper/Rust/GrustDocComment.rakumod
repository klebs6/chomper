our role DocComment::Rules {

    proto token outer-doc-comment { * }

    token OUTER-DOC-COMMENT:sym<a> {
        '///' '/'* <non-slash-or-ws> <-[ \n ]>*
    }

    token OUTER-DOC-COMMENT:sym<b> {
        '///' '/'* <[   \r \t ]> <-[   \r \t ]> <-[ \n ]>*
    }

    token OUTER-DOC-COMMENT:sym<c> {
        '///' <[   \t ]>*
    }

    token OUTER-DOC-COMMENT:sym<d> {
        '/**'
        (    ||    <-[ * ]>
             ||    ( '*'+ <-[ * / ]>)
        )
        <-[ * ]>
        (   ||    <-[ * ]>
            ||    ( '*'+ <-[ * / ]>)
        )
        '*'+
        '/'
    }

    token inner-doc-comment { || '//!' <-[ \n ]>*
        || 
        '/*!' 
        [ 
            <-[ * ]> 
            [ '*'+ <-[ * / ]> ] 
        ]* 
        '*'+ 
        \/
    }

    token other-line-comment { 
        '//' <-[ \n ]>*
    }

    token other-block-comment { 
        '/*'
        [    
            || <-[ * ]>
            || [ '*'+ <-[ * / ]> ]
        ]
        '*'+
        '/'
    }
}

our role DocComment::Actions {

    method OUTER-DOC-COMMENT:sym<a>($/) {
        make $/.Str
    }

    method OUTER-DOC-COMMENT:sym<b> {
        make $/.Str
    }

    method OUTER-DOC-COMMENT:sym<c>($/) {
        make $/.Str
    }

    method OUTER-DOC-COMMENT:sym<d>($/) {
        make $/.Str
    }

    method inner-doc-comment($/) { 
        make $/.Str
    }

    method other-line-comment($/) { 
        make $/.Str
    }

    method other-block-comment($/) { 
        make $/.Str
    }
}

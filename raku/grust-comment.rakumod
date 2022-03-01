use grust-model;
use grust-lex;

#--------------------------------------
=begin comment
\/\/|\/\/\/\/         { BEGIN(linecomment); }
<linecomment>\n       { BEGIN(INITIAL); }
<linecomment>[^\n]*   { }
=end comment
our role Lex::LineComment {

    token line-comment-begin {
        || \/\/\/
        || \/\/
    }

    token line-comment-end {
        \n
    }

    token line-comment-continue {
        <[^\n]>*
    }

    token line-comment {
        <line-comment-begin>
        <line-comment-continue>*
        <line-comment-end>
    }
}

#--------------------------------------
=begin comment
\/\*                  { yy-push-state(blockcomment); }
<blockcomment>\/\*    { yy-push-state(blockcomment); }
<blockcomment>\*\/    { yy-pop-state(); }
<blockcomment>(.|\n)  { }
=end comment
our role Lex::BlockComment {

    token block-comment-begin {
        \/\*
        { 
            self.push-state(XState::<initial>);
            self.push-state(XState::<blockcomment>);
        }
    }

    token block-comment-continue {
        | <block-comment-push>
        | <block-comment-pop>
        | <block-comment-inner>
    }

    token block-comment-push {
        \/\*
        { self.push-state(XState::<blockcomment>) }
    }

    token block-comment-pop {
        \*\/
        { self.pop-state() }
    }

    token block-comment-inner {
        | .
        | \n
    }

    token block-comment-end {
        <?{self.peek-state() eq XState::<initial> }>
    }

    token block-comment {
        <block-comment-begin> 
        <block-comment-continue>* 
        <block-comment-end>
    }
}

our role Lex::DocComment {

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

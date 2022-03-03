use grust-model;
use grust-lex;

our role Rust::Comments 
{
    proto rule comment { * }

    rule comment:sym<line>  {  <line-comment>+ }
    rule comment:sym<block> {  <block-comment> }
}

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

    token line-comment {
        <.ws> <.line-comment-begin> <-[ \r \n ]>* 
    }
}

#--------------------------------------
=begin comment
\/\*                  { yy-push-state(blockcomment); }
<blockcomment>\/\*    { yy-push-state(blockcomment); }
<blockcomment>\*\/    { yy-pop-state(); }
<blockcomment>(.|\n)  { }
=end comment
my @block-comment-states;
our role Lex::BlockComment {

    method push-state($state) {
        @block-comment-states.push: $state;
    }

    method pop-state {
        try @block-comment-states.pop
    }

    method peek-state {
        @block-comment-states[*-1]
    }

    token block-comment-begin {
        \/\*
        { 
            self.push-state(XState::<initial>);
            self.push-state(XState::<blockcomment>);
        }
    }

    token block-comment-continue {
        || <block-comment-push>
        || <block-comment-pop>
        || <block-comment-inner>
    }

    token block-comment-push {
        <?{self.peek-state().Str eq "blockcomment" }>
        \/\*
        { 
            self.push-state(XState::<blockcomment>) 
        }
    }

    token block-comment-pop {
        <?{self.peek-state().Str eq "blockcomment" }>
        \*\/
        { 
            self.pop-state();
        }
    }

    token block-comment-inner {
        <?{self.peek-state().Str eq "blockcomment" }>
        [
            || .
            || \n
        ]
    }

    token block-comment-end {
        <?{self.peek-state().Str eq "initial" }>
        {
            self.pop-state();
        }
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

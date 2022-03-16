use Data::Dump::Tree;

use doxy-comment;

our role Comment::Rules 
{
    proto rule comment { * }

    rule comment:sym<line>  {  <line-comment>+ }
    rule comment:sym<block> {  <block-comment> }
}

our role Comment::Actions {

    method comment:sym<line>($/)  { 

        make 
        parse-doxy-comment(
            "\n/*\n" 
            ~ $<line-comment>>>.made.join("\n")
            ~ "\n*/"
        )
    }

    method comment:sym<block>($/) { make $<block-comment>.made }
}

#--------------------------------------
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

#--------------------------------------
enum BlockCommentState <
blockcomment
initial
>;

my BlockCommentState @block-comment-states;

our role BlockComment::Rules {

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
            self.push-state(BlockCommentState::<initial>);
            self.push-state(BlockCommentState::<blockcomment>);
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
            self.push-state(BlockCommentState::<blockcomment>) 
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

our role BlockComment::Actions {

    method block-comment($/) {
        make $<block-comment-continue>>>.made.join("")
    }

    method block-comment-continue($/) {
        if ~$/.keys[0] eq "block-comment-inner" {
            make ~$/
        }
    }
}

#----------------------------
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


our role Comment::Rules {

    proto token comment { * }
    token comment:sym<line>  { <line-comment>+ }
    token comment:sym<block> { <block-comment> }

    token tok-doubleslash {
        <tok-slash> ** 2
    }

    token line-comment-opener {
        <tok-doubleslash>
    }

    token line-comment-text {
         \N*
    }

    token line-comment-body {
        [<-[/ !]> | <tok-doubleslash>]
        <line-comment-text>
    }

    token line-comment {
        <line-comment-opener>
        <line-comment-body>?
    }

    #----------------------
    proto rule block-comment { * }

    token tok-block-comment-opener { '/*' }
    token tok-block-comment-closer { '*/' }

    rule block-comment:sym<basic> {
        <tok-block-comment-opener>
        <block-comment-body>
        <tok-block-comment-closer>
    }

    token block-comment:sym<empty> {
        <tok-block-comment-opener>
        <tok-star>?
        <tok-block-comment-closer>
    }

    token tok-starstar {
        <tok-star> ** 2
    }

    token tok-anything-but-star-or-bang {
        <-[* !]>
    }

    token tok-anything-but-block-comment-closer {
        (.) <?{$0 !~~ '*/'}>
    }

    rule block-comment-body {
        [<tok-anything-but-star-or-bang> | <tok-starstar> | <block-comment-or-doc> ]
        [<block-comment-or-doc> | <tok-anything-but-block-comment-closer>]*
    }

    token tok-inner-line-doc-opener {
        <tok-slashslash> <tok-bang>
    }

    token tok-anything-but-newline-or-isolatedcr {
        (\N) <?{$0 !~~ <isolated-cr>}>
    }

    token inner-line-doc {
        <tok-inner-line-doc-opener>
        <tok-anything-but-newline-or-isolatedcr>*
    }

    rule inner-block-doc {
        <tok-block-comment-opener>
        <inner-block-doc-body>
        <tok-block-comment-closer>
    }

    rule tok-anything-but-block-doc-closer-or-isolatedcr {
        (.) <?{$0 !~~ <block-doc-closer-or-isolated-cr>}>
    }

    rule block-doc-closer-or-isolated-cr {
        | '*/'
        | <isolated-cr>
    }

    rule inner-block-doc-body {
        [ 
            | <block-comment-or-doc> 
            | <tok-anything-but-block-doc-closer-or-isolatedcr> 
        ]*
    }

    rule outer-line-doc {
        <outer-line-doc-opener>
        <outer-line-doc-body>
    }

    rule outer-line-doc-opener {
        <tok-slash> ** 3
    }

    token tok-not-slash {
        (.) <?{$0 !~~ '/'}>
    }

    rule outer-line-doc-body {
        [
            <tok-not-slash>
            <tok-anything-but-newline-or-isolated-cr>*
        ]?
    }

    rule outer-block-doc-body {
        [
            | <tok-not-star>
            | <block-comment-or-doc>
        ]
        [
            | <block-comment-or-doc>
            | <tok-anything-but-block-doc-closer-or-isolatedcr>
        ]*
    }

    rule outer-block-doc {
        '/**' <outer-block-doc-body> '*/'
    }

    proto rule block-comment-or-doc { * }

    rule block-comment-or-doc:sym<block-comment> {
        <block-comment>
    }

    rule block-comment-or-doc:sym<outer-block-doc> {
        <outer-block-doc>
    }

    rule block-comment-or-doc:sym<inner-block-doc> {
        <inner-block-doc>
    }

    rule isolated-cr {
        \r <!before \n>
    }
}

our role Comment::Actions {

}

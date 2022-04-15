our role LineCommentRule {

    rule line-comment-text {
        \N+
    }

    rule line-comment {
        '//' <line-comment-text>
    }

    rule maybe-comments {
        <line-comment>*
    }
}

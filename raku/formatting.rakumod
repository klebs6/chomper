our sub as-tuple(@list) {
     "({@list.join(',')})"
}

our sub apply-lhs-line(Str $body, :$comment = True) {

    my @lines = $body.lines;

    if @lines.elems > 2 {

        do for @lines {
            $comment 
            ?? "  |$_" 
            !! "|$_"
        }.join("\n")

    } else {

        $body

    }
}

our sub format-python-comment-body($body) {
    qq:to/END/.chomp;
    /**
    {apply-lhs-line($body)}
    */
    END
}

our sub format-module-comment($body) {
    qq:to/END/.chomp;
    /*!
    {apply-lhs-line($body)}
    */
    END
}

our sub collapse-double-newlines($text) {
    $text.subst(:g, "\n\n","\n")
}


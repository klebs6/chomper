our sub as-tuple(@list) {
     "({@list.join(',')})"
}

our sub remove-min-common-leading-whitespace(@lines) {

    my $watermark = Inf;

    for @lines {
        my $idx = $_.match(/\S/).from; 
        if $idx ~~ Int and $idx < $watermark {
            $watermark = $idx;
        }
    }

    do for @lines -> $line {
        if $line.chars > $watermark {
            $line.substr($watermark,Inf)
        } else {
            $line
        }
    }
}

our sub apply-lhs-line(Str $body, :$comment = True) {

    my @lines = remove-min-common-leading-whitespace($body.lines);

    if @lines.elems > 2 {

        do for @lines {
            $comment 
            ?? "  | $_" 
            !! "| $_"
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


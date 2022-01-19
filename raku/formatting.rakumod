
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



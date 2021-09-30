
our sub apply-lhs-line(Str $body) {

    my @lines = $body.lines;

    if @lines.elems > 2 {

        do for @lines {
            "|$_"
        }.join("\n")

    } else {

        $body

    }
}



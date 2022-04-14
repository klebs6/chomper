
our sub get-column-offset(Str $line, Int $col) {
    die if not $line.lines.elems eq 1;
    my @cols = $line.split(" ");
    $line.index(@cols[$col])
}

our sub get-column-offsets(Str $text, Int $col) {
    do for $text.lines -> $line {
        get-column-offset($line, $col)
    }
}

our sub align-column(Str $line, Int :$col, Int :$offset) {

    my $old-offset = get-column-offset($line, $col);
    my $diff       = $offset - $old-offset;

    my $new-line = $line;

    if $diff {
        $new-line.substr-rw($old-offset,0) = " " x $diff;
        $new-line

    } else {
        $line
    }

}

our sub align-columns(Str $text, Int $col) {

    my $max-offset = get-column-offsets($text, $col).max;

    do for $text.lines -> $line {
        align-column($line, col => $col, offset => $max-offset)
    }.join("\n")
}

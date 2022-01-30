
our sub each-line-has-leading-vbar($text) {
    so do for $text.lines -> $line {
        so $line ~~ rule { ^ \| }
    }.all
}

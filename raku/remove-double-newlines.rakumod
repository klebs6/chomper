
our sub remove-double-newlines($text is rw) {
    $text ~~ s:g/\n\n\n/\n\n/;

    #why do we do this several times?
    $text ~~ s:g/\n\n\n/\n\n/;
    $text ~~ s:g/\n\n\n/\n\n/;

    $text
}



our sub get-left-margin(Str $line) {
    my $first = $line.comb(/\S/, 1).Str;
    $line.index($first)
}


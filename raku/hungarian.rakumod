our sub remove-hungarian-constant-prefix(Str $text) {
    my $out = $text;
    $out ~~ s/^<[kK]>_//;
    $out
}

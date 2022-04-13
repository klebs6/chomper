
our sub sort-unique(:$file) {
    my @lines = $file.IO.lines.sort.unique;
    $file.IO.spurt: @lines.join("\n");
}

our sub uniq-from-file(:$file) {

    do if $file.IO.e {

        $file.IO.lines>>.chomp.Set;

    } else {

        Set.new
    }
}

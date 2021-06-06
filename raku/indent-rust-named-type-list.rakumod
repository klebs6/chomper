our sub indent-rust-named-type-list(@list) {

    if @list.elems eq 0 {
        return "";
    }

    my $watermark = get-watermark-from-rargs-list(@list);

    my @new = do for @list {
        indent-column2($_, $watermark)
    };

    if @list.elems > 2 {
        "\n" ~ @new.join(",\n").indent(4)
    } else {
        @list.join(", ")
    }
}

our sub get-watermark-from-rargs-list(@list) {

    my $watermark = @list.reduce: sub ($a, $b) {

        my $aval = $a ~~ Str ?? $a.chomp.trim.index(" ") // 0 !! $a;

        my $bval = $b.chomp.trim.index(" ") // 0;

        ($aval, $bval).max()
    };

    #this is janky why?
    if $watermark ~~ Str {
        $watermark = $watermark.chomp.trim.index(" ") // 0;
    }

    $watermark
}

our sub indent-column2($text, $watermark) {

    #indent column2

    my ($a, @b) = $text.split(" ");

    my $len = $watermark - $a.chars;

    my $pad = " " ~ (" " x $len);

    $a ~ $pad ~ @b.join(" ")
}


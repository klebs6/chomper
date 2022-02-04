our sub indent-rust-named-type-list(@list) {

    if @list.elems eq 0 {
        return "";
    }

    my $watermark = get-watermark-from-rargs-list(@list);

    my @new = do for @list {
        indent-column2($_, $watermark)
    };

    if @list.elems > 2 || @list.elems > 1 && @list.join(", ").chars > 16 {
        "\n" ~ @new.join(",\n").indent(8)
    } else {
        @list.join(", ")
    }
}

our sub get-watermark-from-rargs-list(@list) {

    if @list.elems eq 0 {
        return 0;
    }

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

our sub align-first-equals(@stmts) {

    my @indices = do for @stmts -> $stmt {
        my $idx  = $stmt.index("=");
        $idx
    };

    my $max = @indices.max;

    for @stmts <-> $stmt {
        my $idx  = $stmt.index("=");
        my $diff = $max - $idx;
        $stmt.substr-rw($idx - 1,0) = " " x $diff;
    };

    @stmts
}

our sub type-from-rust-let-statement($stmt) {
    $stmt.split(":")[1].trim.split(" ")[0]
}

our sub rust-let-statements-align-type(@stmts) {

    my @indices = do for @stmts -> $stmt {
        my $type = type-from-rust-let-statement($stmt);
        my $idx  = $stmt.index($type);
        $idx
    };

    my $max = @indices.max;

    for @stmts <-> $stmt {
        my $type = type-from-rust-let-statement($stmt);
        my $idx  = $stmt.index($type);
        my $diff = $max - $idx;
        $stmt.substr-rw($idx - 1,0) = " " x $diff;
    };
    align-first-equals(@stmts)
}

our sub indent-column2($text, $watermark) {

    #indent column2

    my ($a, @b) = $text.split(" ");

    my $len = $watermark - $a.chars;

    my $pad = " " ~ (" " x $len);

    $a ~ $pad ~ @b.join(" ")
}


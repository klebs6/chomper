
our sub format-textwidth(Str $text, Int $approx-width) {

    my @lines = $text.split("\n");

    my @out = do for @lines -> $line {
        my $input = $line.chomp.split("\n").join(" ");

        my @words = $input.words;
        my $count = 0;
        my @result;
        my @cur;

        for @words {
            if $count < $approx-width {
                @cur.push: $_;
                $count += $_.chars;
            } else {
                @result.push: @cur.join(" ");
                @cur = [];
                $count = 0;
                redo;
            }
        }
        @result.push: @cur.join(" ");
        @result.join("\n")
    };

    @out.join("\n\n")
}


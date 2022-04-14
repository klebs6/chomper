
our sub ensure-textwidth(Str $text, Int $approx) {

    my $line = "";
    my @lines;

    my @words = $text.words;

    my $cur = 0;

    sub flush-line {

        if $line {

            @lines.push: $line;

            $cur = 0;
            $line = "";
        }
    }

    for @words -> $word {

        $cur += $word.chars + 1;

        $line = "$line $word".trim-trailing;

        if $cur > $approx {
            flush-line();
        }
    }

    flush-line();

    @lines.join("\n")
}


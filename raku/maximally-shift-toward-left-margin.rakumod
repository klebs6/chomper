use get-left-margin;

our sub maximally-shift-toward-left-margin($text) {

    my @lines   = $text.lines;
    my $cur-min = Inf;

    for @lines -> $line {

        if $line.chomp.trim {

            #`{
                has meaningful text (more than just
                whitespace)
            }

            $cur-min = [$cur-min, get-left-margin($line)].min;
        } 
    }

    do for @lines {

        if $cur-min < $_.chars {
            $_.substr($cur-min, *)
        } else {
            $_
        }

    }.join("\n")
}

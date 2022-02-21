use MONKEY-TYPING;
augment class List {
    method align($delim) {
        my @splits = self>>.split($delim);
        my $watermark = do for @splits {
            $_[0].chars
        }.max;
        do for @splits {
            my $len  = $_[0].chars;
            my $diff = $watermark - $len;
            my $pad = " " x $diff;
            $_[0] ~ $pad ~ $delim ~ " " ~ $_[1]
        }
    }
}

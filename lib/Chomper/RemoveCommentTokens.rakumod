use Chomper::GetLeftMargin;

our sub remove-comment-tokens($in) {

    my $opener = $in.substr(0,5) ~~ /\/\*\*/ ?? '/**' !! '/*';
    my $offset = $opener ~~ '/**' ?? 4 !! 3;
    my $closer = '*/';

    my $delim  = '*' ;
    my $delim2 = '|' ;

    my $lidx   = $in.indices($opener)[0];
    my $ridx   = $in.indices($closer)[*-1];
    my $body   = $in.substr($lidx + $offset .. $ridx - 1);

    my @lines  = $body.split("\n");

    my @stripped = do for @lines {
        #TODO: resolve!
        #my $line = $_.trim;
        my $line = $_;

        my $margin = get-left-margin($line);

        my $trimmed = $_.trim;

        if $trimmed.starts-with($delim) or $trimmed.starts-with($delim2) {
            $trimmed = $trimmed.substr(1 .. *);
        }
        #say "trimmed: $trimmed";

        "{' ' x $margin}$trimmed"
    };

    @stripped.join("\n") ~ "\n"
}

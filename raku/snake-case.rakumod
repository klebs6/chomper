our sub remove-duplicate-segments($filename) {
    my ($name, $ext) = $filename.split(".");

    my @segs = $name.split(/_/);
    my @builder = [];

    for @segs {
        @builder.push: $_ if not @builder.grep($_);
    }
    @builder.join("_") ~ ".$ext"

}
our sub snake-case($name) {

    my $result = $name;

    #split long strings of uppercase characters
    $result ~~ s:g/(<[A..Z]>{3..*}) <?before <[A..Z]> <[a..z ]>>/{$0.lc}_/;
    $result ~~ s:g/(<[A..Z]>+) <?before \.>/_{$0.lc}/;

    $result ~~ s:g/<?after <[a..z]>> (<[A..Z]> ** 1) <?before <[a..z]>>/_{$0.lc}/; 
    $result ~~ s:g/<?after <[a..z]>> (<[A..Z 0..9]> ** 2..*) <?before <[a..z]>>/_{$0.lc}/; 
    $result ~~ s:g/<wb> (<[A..Z 0..9]>)/{$0.lc}/; 
    $result ~~ s:g/<?after _> (<[A..Z]>) ** 1 <?before <[a..z]>>/{$0.lc}/;

    #trim trailing underscores
    $result ~~ s:g/ _* $//;

    #make lowercase two character sigils like uU cR dF
    $result ~~ s:g/_(<[a..z]><[A..Z]>)_/_{$0.lc}_/;
    $result ~~ s:g/__/_/;

    $result.lc
}


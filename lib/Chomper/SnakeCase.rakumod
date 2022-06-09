use Chomper::AvoidKeywords;
use Chomper::Hungarian;
use Chomper::Case;
use Chomper::SegmentRemoveDuplicates;
use Chomper::Locations;

our sub snake-case($name, $remove-dup = False) {

    #this is what we want most of the time
    if $name eq $name.uc {
        return $name;
    }

    my $input = $name;

    my $result = $name;

    my $uc = token { <[A..Z]> };
    my $lc = token { <[a..z]> };

    $result ~~ s:g/($lc) ($uc $uc $uc) ($lc)/$0_{$1.lc}_$2/;
    $result ~~ s:g/($lc) ($uc $uc $uc) <wb>/$0_{$1.lc}/;

    $result ~~ s:g/($lc) ($uc $uc) ($lc)/$0_{$1.lc}$2/;

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
    $result ~~ s/^_//;

    my $output = do if $remove-dup {
        remove-duplicate-segments($result.lc)

    } else {

        #this call to avoid-keywords should probably go 
        #somewhere else, but it is useful here
        #
        #alternatively, we should call a separate function
        #everywhere snake-case is currently called
        avoid-keywords(avoid-hungarian($result.lc))
    };

    maybe-update-snake-case-file(:$input,:$output);

    $output
}

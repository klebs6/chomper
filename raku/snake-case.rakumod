our sub snake-case($name) {

    my $result = $name;

    $result ~~ s:g/<?after <[a..z]>> (<[A..Z]> ** 1) <?before <[a..z]>>/_{$0.lc}/; 
    $result ~~ s:g/<?after <[a..z]>> (<[A..Z 0..9]> ** 2..*) <?before <[a..z]>>/_{$0.lc}/; 
    $result ~~ s:g/<wb> (<[A..Z 0..9]>)/{$0.lc}/; 
    $result ~~ s:g/<?after _> (<[A..Z]>) ** 1 <?before <[a..z]>>/{$0.lc}/;

    #trim trailing underscores
    $result ~~ s:g/ _* $//;

    $result
}


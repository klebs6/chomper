our $snake-case-file = 
"/Users/kleb/bethesda/work/repo/translator/raku/snake-cased.txt";

our sub sort-uniq-snake-case-file {

    my @uniq = qqx/sort $snake-case-file | uniq/;
    spurt $snake-case-file, "{@uniq.join('')}\n";
}

our sub snake-to-camel($input) {
    my $type-stripped = $input.subst(/_t$/, "");
    $type-stripped.split("_")>>.tc.join("")
}

our sub remove-duplicate-segments($filename) {
    my ($name, $ext) = $filename.split(".");

    my @segs = $name.split(/_/);
    my @builder = [];

    for @segs {
        @builder.push: $_ if not @builder.grep($_);
    }
    @builder.join("_") ~ ".$ext"

}
our sub snake-case($name, $remove-dup = False) {
    my $input = $name;

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

    if $input.trim ne $output.trim {
        spurt $snake-case-file, "$input $output\n", :append;
    }

    $output
}

our sub avoid-hungarian($in) {
    my $out = $in.subst(/^m_/, "");
    $out ~~ s/^f_//;
    $out ~~ s/^i_//;
    $out ~~ s/^b_//;
    $out ~~ s/^e_//;
    $out ~~ s/^p_//;
    $out ~~ s/^c_//;
    $out ~~ s/^s_//;
    #$out ~~ s/^n_//;
    $out ~~ s/^v_//;
    $out ~~ s/^u_//;

    #this is done with regular type translations
=begin comment
    #"class", "struct", "enum", any others? any problems?
    $out ~~ s/^C<?before <[A..Z]>>//;
    $out ~~ s/^S<?before <[A..Z]>>//;
    $out ~~ s/^E<?before <[A..Z]>>//;
=end comment

    $out
}

our sub avoid-keywords($s) {

    my %bad = %(
        loop  => "loop_",
        type  => "ty",
        in    => "in_",
        match => "match_",
        impl  => "impl_",
        self  => "self_",
        str   => "str_",
        ref   => "ref_",
        box   => "box_",
        fn    => "fn_",
    );

    %bad{$s} // $s
}

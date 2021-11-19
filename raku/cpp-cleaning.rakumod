our sub cleanup-cpp-keywords(Str $text) {
    my $in = $text;

    my $virtual    = rule  { '/*' virtual '*/' };
    my $static     = rule  { '/*' static  '*/' };
    my $identifier = token { <[A..Z a..z 0..9]>+ }
    my $internal   = rule  { '/**' '@internal' '*/' }

    my $friend = regex {
        "friend class " $identifier ";"
    }

    $in ~~ s:g/$static//;
    $in ~~ s:g/$virtual//;
    $in ~~ s:g/$friend//;
    $in ~~ s:g/$internal//;

    $in ~~ s:g/public\://;
    $in ~~ s:g/private\://;
    $in ~~ s:g/protected\://;
    $in ~~ s:g/\n\n\n/\n\n/;

    $in
}

#--------------------------
our sub convert-problematic-comment-tokens(Str $text) {
    my $in = $text;

    my $line-comment-bang       = token  { '//!' }
    my $line-comment-bang-arrow = token  { '//!<' }
    my $line-comment-arrow      = token  { '///<' }

    $in ~~ s:g/$line-comment-bang/\/\/\//;
    $in ~~ s:g/$line-comment-bang-arrow/\/\/\//;
    $in ~~ s:g/$line-comment-arrow/\/\/\//;

    $in
}

#--------------------------
our sub collapse-unwanted-long-separators(Str $text) {
    my $in = $text;

    my $sep1 = regex {
        \/\/ '='+ $$
    };

    my $sep2 = regex {
        ^^ \/\/ '-'+ $$
    };

    $in ~~ s:g/$sep1//;
    $in ~~ s:g/$sep2//;

    $in
}

#--------------------------
our sub insert-typename-before-valid-namespaces(Str $text, :@valid-namespaces) {
    my $in = $text;

    for @valid-namespaces -> $x {
        $in ~~ s:g/<!after 'typename '>($x\:\:)/typename $0/;
    }

    $in
}

#--------------------------

our sub remove-unwanted-tokens(Str $text, :@unwanted) {
    my $in = $text;

    for @unwanted -> $remove-me {
        $in ~~ s:g/$remove-me//;
    }

    $in
}


our sub remove-unwanted-cpp-keywords(Str $text) {
    my $in = $text;

    my @remove-me = qw<
    noexcept
    >;

    for @remove-me -> $x {
        $in ~~ s:g/$x//;
    }

    $in
}

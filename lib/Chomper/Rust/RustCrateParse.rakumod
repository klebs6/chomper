use Chomper::Rust::GrustCrateGrammar;
use Data::Dump::Tree;
use Terminal::ANSIColor;
use Chomper::CargoWorkspace;

my $empty-line = regex {
    ^^ \h* $$ \n
};

my $margin-hugger = regex {
    ^ <?before \S>
}

#this algorithm is a bit tricky...
#
#basically, we want to extract all text snippets
#from our source files which may be independently
#parsed as a rust crate.  to do this, we split on
#lines which are entirely whitespace first.
#second, we want to stitch these fragments back
#together in such a way as to group fragments
#which belong together in a crate-atom.  there are
#a number of different aspects to this task we
#need to consider -- please see the algorithm
#itself below for the full elaboration.
our sub stitch-fragments(@fragments) {

    my @stitched = [];

    my $composite;

    my $tail-active = False;

    for @fragments -> $fragment {

        next if not $fragment;

        if $fragment.chomp eq "}" {

            $composite ~= "\n" ~ $fragment;

            @stitched.push: $composite;

            $composite   = Nil;

            $tail-active = False;

            next;
        }

        #here we dont know whether we are going to
        #have a tail for this item, but we can
        #check whether the item is *from* a tail
        my Bool $whole-item-head-or-terminator 
        = so $fragment ~~ $margin-hugger;

        if $whole-item-head-or-terminator {

            if $tail-active {
                #in terminator, so flush

                $composite ~= "\n" ~ $fragment;
                @stitched.push: $composite;
                $composite   = Nil;

            } else {

                #we are either a whole item, or
                #a head

                #maybe flush previous
                if $composite {
                    @stitched.push: $composite;
                }

                $composite = $fragment;
            }

            #either way, we are no longer in a
            #tail
            $tail-active = False;

        } else {

            #indicates that this fragment ends the
            #item we are currently working on, and so
            #should flush/reset
            my Bool $fragment-ends-item = do if $fragment.lines.elems gt 1 {
                so $fragment.lines[*-1] ~~ $margin-hugger 
            } else {
                False
            };

            if $fragment-ends-item {

                $composite ~= "\n" ~ $fragment;
                @stitched.push: $composite;
                $composite   = Nil;
                $tail-active = False;

            } else {
                $composite ~= "\n" ~ $fragment;
                $tail-active = True;
            }
        }
    }

    @stitched
}

our sub split-into-crate-snippets(:$file) {

    my $text = $file.IO.slurp;

    my @fragments = $text.split($empty-line);

    stitch-fragments(@fragments)
}

our sub can-parse-as-crate(:$snippet) returns Bool {
    so Crate::Grammar.parse($snippet)
}

our sub determine-rust-crate-parse-errors-for-file(:$file, :$errfile) {

    sub write-header(:$file, :$errfile) {
        my $header = "//-------------------------[error parses for $file]";
        $errfile.IO.spurt: "\n" ~ $header, :append;
    }

    sub write-snippet(:$snippet, :$errfile) {
        $errfile.IO.spurt: "\n----------", :append;
        $errfile.IO.spurt: "\n" ~ $snippet, :append;
    }

    my @snippets = split-into-crate-snippets(:$file);

    my $found-error  = False;

    my @bad-snippets = [];

    for @snippets -> $snippet {

        if not can-parse-as-crate(:$snippet) {
            $found-error = True;
            @bad-snippets.push: $snippet;
        }
    }

    if $found-error {

        colored("   found some error while processing :$file! bad!", "red");
        write-header(:$file, :$errfile);

        for @bad-snippets -> $snippet {
            write-snippet(:$snippet, :$errfile);
        }

    } else {

        colored("   did not find error in :$file! great!", "green");
    }

    $found-error
}

our sub determine-rust-crate-parse-errors(:$crate, :$errfile, :$goodfile) {

    say "-------processing $crate";

    LEAVE say "";

    my $found-error = False;

    for get-crate-files($crate) -> $file {

        say "processing $file";

        $found-error |= determine-rust-crate-parse-errors-for-file(
            :$file, 
            :$errfile
        );
    }

    if not $found-error {
        say "crate $crate is free of parse errors!";
        $goodfile.IO.spurt: "\n" ~ $crate, :append;
    }

    $found-error
}

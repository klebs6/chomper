use formatting;

my $ex = qq:to/END/;
Run code in a new Python process, and monitor peak
memory usage.

Returns
-------
    duration : float
Duration in seconds (including Python startup time)

    peak_memusage : float
    Peak memory usage (rough estimate only) in bytes
END

our grammar Python3::DocCommentSection {

    rule TOP {
        <.ws> <python3-doc-comment-section>
    }

    rule returns-body {

    }

    rule params-body {

    }

    #--------------------------
    proto rule python3-doc-comment { * }

    rule python3-doc-comment-section:sym<returns> {
        Returns \-+
        <returns-body>
    }

    rule python3-doc-comment-section:sym<params> {
        Params \-+
        <params-body>
    }

    rule python3-doc-comment-section:sym<prelude> {
        .*
    }
}

our class PythonDocComment {

    has Str   $.text is required;

    has Match $.prelude;
    has Match $.return-section;
    has Match $.params-section;

    has Regex $!delim = rule { 
       | ^^ Returns \-+
       | ^^ Params  \-+
    };

    submethod TWEAK {

        my @indices = $!text.match(:g, $!delim)>>.from;

        my $cur = 0;
        my @ranges = do for @indices {
            my $range = $cur..($_ - 1);
            $cur = $_;
            $range
        };

        @ranges.push: @indices[*-1]..*;

        for @ranges {
            my $block = $!text.substr($_);
            self.consume-block($block);
        }
    }

    method consume-block(Str $block) {

    }

    method extract-return-values {
        []
    }

    method as-rust-comment {
        format-python-comment-body($!text)
    }
}

our sub parse-python-doc-comment(Str $text) {
    PythonDocComment.new( :$text )
}

our sub maybe-extract-return-value($parsed) {
    my @rvals = $parsed.extract-return-values();
    @rvals.elems ??  as-tuple(@rvals) !! ""
}

our sub as-rust-comment($parsed) {
    $parsed.as-rust-comment()
}

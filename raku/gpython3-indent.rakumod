
our role Python3::Grammar::Indent {

    proto token SKIP { * }
    token SKIP:sym<SPACES>       { <SPACES> }
    token SKIP:sym<COMMENT>      { <COMMENT> }
    token SKIP:sym<LINE_JOINING> { <LINE_JOINING> }

    token SPACES {
        <[ \h  \t ]>+
    }

    token COMMENT {
        <COMMENT_NONEWLINE> <NEWLINE>?
    }

    token COMMENT_NONEWLINE {
        <POUND> <-[ \r \n ]>* 
    }

    token LINE_JOINING {
        '\\' <SPACES>?
        <newline-token>
    }

    token newline-token {
        || \r?  \n
        || \r
    }

    token enter_scope { <?> { so $*debug and say "entering scope" } }
    token leave_scope { <?> { so $*debug and say "leaving scope"  } }

    token INDENT {
        <?{ $*indents-needed > 0 }>
        <.enter_scope>
        { $*indents-needed--; }
    }

    token DEDENT {
        <?{ $*dedents-needed > 0 }>
        <.leave_scope>
        { $*dedents-needed--; }
    }

    token NEWLINE {
        <?{$*opened eq 0}>
        [    
            || ^ <SPACES>
            || <newline-token>+ <SPACES>?
        ]
        { 
            if not self.should-skip-indent($/) {
                if $/<SPACES>:exists {
                    my $indent = $/<SPACES>.Str.chars;
                    self.handle-indentation($indent, $/) 
                } else {
                    self.handle-indentation(0, $/) 
                }
            }
        }
        [ <INDENT> | <DEDENT>* ]?
    }

    method peek-indent-stack {
        @*INDENTATION.elems ?? @*INDENTATION[*-1] !! 0
    }

    method handle-indentation($indent,$/) {

        my $previous = self.peek-indent-stack();

        so $*debug and say "handle-indentation, prematch: \n{$/.prematch}\n--------indent: $indent, previous: $previous";

        if $indent eq $previous {
            return;

        } elsif $indent > $previous {

            @*INDENTATION.push: $indent;
            $*indents-needed++;

        } else {

            # Possibly emit more than 1 DEDENT token.
            while @*INDENTATION.elems > 0 and @*INDENTATION[*-1] > $indent {
                @*INDENTATION.pop();
                $*dedents-needed++;
            }
        }

        so $*debug and say "handle-indentation finished, {@*INDENTATION}, indents-needed: {$*indents-needed}, dedents-needed: {$*dedents-needed}";
    }

    method on-blank-line($/) {
        my $postmatch-line = $/.postmatch.Str.split("\n")[0];
        my Bool $on-blank-line = not so $postmatch-line.chomp.trim;
        if $on-blank-line {
            so $*debug and say "on-blank-line, prematch:\n{$/.prematch}";;
        }
        $on-blank-line
    }

    method should-skip-indent($/) {
        my Bool $opened = $*opened > 0;
        my Bool $blank-line = self.on-blank-line($/);
        my Bool $should-skip = $opened || $blank-line;
        if $should-skip {
            so $*debug and say "should-skip:\n{$/.prematch}";
        }
        $should-skip
    }

}

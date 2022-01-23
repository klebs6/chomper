our role Python3Newline {

    token INDENT { 
        'indent'
        #{ @*INDENTATION.push(NEW_INDENTATION); } 
    }

    token DEDENT { 'dedent' }

    token NEWLINE {
        [
            | ^^ <SPACES>
            | [ '\r'?  '\n' |  '\r'] <SPACES>?
        ]
        { 
            #my $indentation-count = 
            #self.get-indentation-count(~$/<SPACES>);
            self.handle-indentation(~$/<SPACES>)



        }
    }

    method handle-indentation(Str $spaces) {

    }

    # Calculates the indentation of the provided
    # spaces, taking the following rules into
    # account:
    #
    # "Tabs are replaced (from left to right) by
    #  one to eight spaces such that the total
    #  number of characters up to and including the
    #  replacement is a multiple of eight [...]"
    #
    # https://docs.python.org/3.1/reference/lexical_analysis.html#indentation
    method get-indentation-count(Str $spaces) {

        my $count = 0;

        for $spaces.chars {
            given $_ {
                when " " {
                    $count++;
                }
                when "\t" {
                    $count += 8 - ($count % 8);
                }
                default {
                    die "non-space character in string";
                }
            }
        }

        $count
    }

    method newline-hook {
        =begin comment
         #|{
         String newLine = getText().replaceAll("[^\r\n]+", "");
         String spaces = getText().replaceAll("[\r\n]+", "");
         int next = _input.LA(1);

         if (opened > 0 || next == '\r' || next == '\n' || next == '#') {
           // If we're inside a list or on a blank line, ignore all indents, 
           // dedents and line breaks.
           skip();
         }
         else {
           emit(commonToken(NEWLINE, newLine));

           int indent   = getIndentationCount(spaces);
           int previous = indents.isEmpty() ? 0 : indents.peek();

           if (indent == previous) {
             // skip indents of the same size
             // as the present indent-size
             skip();
           }
           else if (indent > previous) {
             indents.push(indent);
             emit(commonToken(Python3Parser.INDENT, spaces));
           }
           else {
             // Possibly emit more than 1 DEDENT token.
             while(!indents.isEmpty() && indents.peek() > indent) {
               this.emit(createDedent());
               indents.pop();
             }
           }
         }
       }
        =end comment
    }

    token SKIP {
        | <SPACES>
        | <COMMENT>
        | <LINE_JOINING>
    }
}

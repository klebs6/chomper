
sub reformat-body($body, :$python = False) {
    if $python {
        $body.chomp.indent(4)
    } else {
        "    {$body.trim.chomp.indent(4)}"
    }
}

our sub wrap-body-todo($body, :$preamble = "", :$python = False) {

=begin comment
    if not $body.chomp.trim {
        return "";
    }
=end comment
    my $reformatted-body = reformat-body($body, :$python);

    my $wrapped = do if True or $body.chomp.trim {

        if $preamble {
            qq:to/END/
            todo!();
                    /*
            {$preamble}
                $reformatted-body
                    */
            END

        } else {
            qq:to/END/
            todo!();
                    /*
                $reformatted-body
                    */
            END

        }
    } else {
        ""
    };

    $wrapped.chomp
}

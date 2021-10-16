
our sub wrap-body-todo($body, :$preamble = "") {

    my $wrapped = do if True or $body.chomp.trim {

        if $preamble {
            qq:to/END/
            todo!();
                    /*
            {$preamble}
                    {$body.trim.chomp.indent(4)}
                    */
            END

        } else {
            qq:to/END/
            todo!();
                    /*
                    {$body.trim.chomp.indent(4)}
                    */
            END

        }
    } else {
        ""
    };

    $wrapped.chomp
}

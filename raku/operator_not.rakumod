use util;

sub rparse-operator-not($submatch) {

    #has the same fields
    rparse-operator-into-bool($submatch)
}

our sub translate-operator-not($submatch, $body, $rclass) {

    my (
        $rcomments-list,
        $rinline, 
        $rtype 
    ) = rparse-operator-not($submatch);

    my $rcomment       = format-rust-comments($rcomments-list);

    qq:to/END/;
    impl Not for $rclass \{
        type Output = {get-naked($rtype)};

        $rcomment
        {$rinline}fn not(self) -> Self::Output \{
            todo!();
            /*
            {$body.trim.chomp.indent(4)}
            */
        \}
    \}
    END
}




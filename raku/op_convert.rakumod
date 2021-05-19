use util;

our sub translate-op-convert($submatch, $body, $rclass) {

    my ( $rcomments-list,
            $rinline, 
            $rtype) = 
        rparse-operator-compare($submatch, $rclass);

    my $rcomment       = format-rust-comments($rcomments-list);

    qq:to/END/;
    impl From<{$rtype}> for $rclass \{

        $rcomment
        {$rinline}fn from(other: $rtype) -> Self \{
            todo!();
            /*
            {$body.trim.chomp.indent(4)}
            */
        \}
    \}
    END
}


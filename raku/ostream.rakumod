use util;

our sub translate-op-ostream(
    $submatch, 
    $body, 
    $rclass) 
{
    my ($rcomments-list, $rtype)  = 
        rparse-operator-ostream($submatch, $rclass);

    my $rcomment       = format-rust-comments($rcomments-list);

    qq:to/END/;
    impl fmt::Display for $rtype \{
        $rcomment
        fn fmt\(&self, f\: &mut fmt\:\:Formatter<'_>\) -> fmt\:\:Result \{
            todo!\(\);
            /*
            {$body.trim.chomp.indent(4)}
            */
        \}
    \}
    END

}


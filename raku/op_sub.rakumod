use util;

our sub translate-op-sub($submatch, $body, $rclass) {

    my ( $rcomments-list,
            $rinline, 
            $return-type, 
            $roperand0,
            $roperand1) = 
        rparse-operator($submatch, $rclass);

    my $rcomment       = format-rust-comments($rcomments-list);

    qq:to/END/;
    impl Sub<{$roperand1}> for $roperand0 \{

        type Output = $return-type;

        $rcomment
        {$rinline}fn sub(self, other: $roperand1) -> Self::Output \{
            todo!();
            /*
            {$body.trim.chomp.indent(4)}
            */
        \}
    \}
    END


}

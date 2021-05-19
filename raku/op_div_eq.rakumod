use util;

our sub translate-op-div-eq($submatch, $body, $rclass) {

    my ( $rcomments-list,
            $rinline, 
            $rtype, 
            $roperand,
            $rfunction-args-list) = 
        rparse-operator-assign($submatch);

    my $rcomment       = format-rust-comments($rcomments-list);
    my $rfunction-args = format-rust-function-args($rfunction-args-list);

    qq:to/END/;
    impl DivAssign<{$roperand}> for $rtype \{
        $rcomment
        {$rinline}fn div_assign(&mut self, {$rfunction-args-list}) \{
            todo!();
            /*
            {$body.trim.chomp.indent(4)}
            */
        \}
    \}
    END

}


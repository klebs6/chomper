use util;

our sub translate-op-index($submatch, $body, $rclass) {

    my ( $rcomments-list,
            $rinline, 
            $rconst,
            $rtype, 
            $roperand0,
            $roperand1,
            $rfunction-args-list) = 
        rparse-operator-index($submatch,$rclass);

    my $rcomment       = format-rust-comments($rcomments-list);
    my $rfunction-args = format-rust-function-args($rfunction-args-list);

    if $rconst {
        qq:to/END/;
        impl Index<{$roperand1}> for $roperand0 \{
            type Output = $rtype;
            $rcomment
            {$rinline}fn index(&self, {$rfunction-args-list}) -> &Self::Output \{
                todo!();
                /*
                {$body.trim.chomp.indent(4)}
                */
            \}
        \}
        END
    } else {
        qq:to/END/;
        impl IndexMut<{$roperand1}> for $roperand0 \{
            $rcomment
            {$rinline}fn index_mut(&mut self, {$rfunction-args-list}) -> &mut Self::Output \{
                todo!();
                /*
                {$body.trim.chomp.indent(4)}
                */
            \}
        \}
        END
    }
}

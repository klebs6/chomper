use util;

our sub translate-op-add($submatch, $body, $rclass) {

    my ( $rcomments-list,
            $rinline, 
            $rtype, 
            $roperand,
            $rfunction-args-list) = 
        rparse-operator($submatch, $rclass);

    my $rcomment       = format-rust-comments($rcomments-list);
    my $rfunction-args = format-rust-function-args($rfunction-args-list);

    $roperand = get-naked($roperand);

    qq:to/END/;
    impl Add<&{$roperand}> for $rtype \{

        type Output = Self;

        $rcomment
        {$rinline}fn add(self, other: &$roperand) -> Self::Output \{
            todo!();
            /*
            {$body.trim.chomp.indent(4)}
            */
        \}
    \}
    END
}

our sub translate-op-add-eq($submatch, $body, $rclass) {

    my ( $rcomments-list,
            $rinline, 
            $rtype, 
            $roperand,
            $rfunction-args-list) = 
        rparse-operator-assign($submatch);

    my $rcomment       = format-rust-comments($rcomments-list);
    my $rfunction-args = format-rust-function-args($rfunction-args-list);

    $roperand = get-naked($roperand);

    qq:to/END/;
    impl AddAssign<&{$roperand}> for $rtype \{
        $rcomment
        {$rinline}fn add_assign(&mut self, other: &{$roperand}) \{
            todo!();
            /*
            {$body.trim.chomp.indent(4)}
            */
        \}
    \}
    END
}

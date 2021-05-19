use util;
use grammar;

our sub translate-op-eq($submatch, $body, $rclass) {

    my ( $rcomments-list,
            $rinline, 
            $roperand0,
            $roperand1) = 
        rparse-operator-eq($submatch, $rclass);

    my $rcomment = format-rust-comments($rcomments-list);

    $roperand1 = get-naked($roperand1);

    qq:to/END/;
    impl PartialEq<{$roperand1}> for $roperand0 \{
        $rcomment
        {$rinline}fn eq(&self, other: &$roperand1) -> bool \{
            todo!();
            /*
            {$body.trim.chomp.indent(4)}
            */
        \}
    \}

    {if $roperand0 ~~ $roperand1 {
        "impl Eq for $roperand0 \{\}"
    }else {
        ""
    }}
    END
}

our sub translate-op-lt($submatch, $body, $rclass) {

    my ( $rcomments-list,
            $rinline, 
            $roperand0,
            $roperand1) = 
        rparse-operator-eq($submatch, $rclass);

    my $rcomment = format-rust-comments($rcomments-list);

    $roperand1 = get-naked($roperand1);

    qq:to/END/;
    impl Ord<{$roperand1}> for $roperand0 \{
        $rcomment
        {$rinline}fn cmp(&self, other: &$roperand1) -> Ordering \{
            todo!();
            /*
            {$body.trim.chomp.indent(4)}
            */
        \}
    \}

    impl PartialOrd<{$roperand1}> for $roperand0 \{
        {$rinline}fn partial_cmp(&self, other: &$roperand1) -> Option<Ordering> \{
            Some(self.cmp(other))
        \}
    \}
    END

}

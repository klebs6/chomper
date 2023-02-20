use Chomper::Util;
use Chomper::WrapBodyTodo;

our sub translate-op-bitand($submatch, $body, $rclass) {

    my ( 
        $rcomments-list,
        $rinline, 
        $return-type, 
        $roperand0,
        $roperand1, 
        $tags
    ) 
    = rparse-operator($submatch, $rclass);

    my $rcomment = format-rust-comments($rcomments-list);

    qq:to/END/;
    impl BitAnd<{$roperand1}> for $roperand0 \{
        type Output = $return-type;

        $rcomment
        {$tags}
        {$rinline}fn bitand(self, other: $roperand1) -> Self::Output \{
            {wrap-body-todo($body)}
        \}
    \}
    END
}

our sub translate-op-bitand-assign($submatch, $body, $rclass) {

    my ( 
        $rcomments-list,
        $rinline, 
        $rtype, 
        $roperand,
        $rfunction-args-list, 
        $tags) = 
        rparse-operator-assign($submatch);

    my $rcomment = format-rust-comments($rcomments-list);

    qq:to/END/;
    impl BitAndAssign<{$roperand}> for $rtype \{
        $rcomment
        {$tags}
        {$rinline}fn bitand_assign(&mut self, {$rfunction-args-list}) \{
            {wrap-body-todo($body)}
        \}
    \}
    END
}

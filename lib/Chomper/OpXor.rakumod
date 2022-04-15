use Chomper::Util;
use Chomper::WrapBodyTodo;

our sub translate-op-xor($submatch, $body, $rclass) {

    my ( $rcomments-list,
            $rinline, 
            $return-type, 
            $roperand0,
            $roperand1) = 
        rparse-operator($submatch, $rclass);

    my $rcomment = format-rust-comments($rcomments-list);

    qq:to/END/;
    impl BitXor<{$roperand1}> for $roperand0 \{
        type Output = $return-type;

        $rcomment
        {$rinline}fn bitxor(self, other: $roperand1) -> Self::Output \{
            {wrap-body-todo($body)}
        \}
    \}
    END

}


use Chomper::Util;
use Chomper::WrapBodyTodo;

our sub translate-op-mul($submatch, $body, $rclass) {

    my ( $rcomments-list,
            $rinline, 
            $return-type, 
            $roperand0,
            $roperand1) = 
        rparse-operator-mul($submatch, $rclass);

    my $rcomment = format-rust-comments($rcomments-list);

    $roperand1 = get-naked($roperand1);

    qq:to/END/;
    impl Mul<&{$roperand1}> for $roperand0 \{
        type Output = $return-type;

        $rcomment
        {$rinline}fn mul(self, other: &$roperand1) -> Self::Output \{
            {wrap-body-todo($body)}
        \}
    \}
    END
}

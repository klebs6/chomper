use Chomper::Util;
use Chomper::WrapBodyTodo;

our sub translate-op-mul-eq($submatch, $body, $rclass) {

    my ( $rcomments-list,
            $rinline, 
            $rtype, 
            $roperand,
            $rfunction-args-list) = 
        rparse-operator-assign($submatch);

    my $rcomment       = format-rust-comments($rcomments-list);
    my $rfunction-args = format-rust-function-args($rfunction-args-list);

    qq:to/END/;
    impl MulAssign<{$roperand}> for $rtype \{
        $rcomment
        {$rinline}fn mul_assign(&mut self, {$rfunction-args-list}) \{
            {wrap-body-todo($body)}
        \}
    \}
    END
}

use Chomper::Util;
use Chomper::WrapBodyTodo;

our sub translate-op-negate($submatch, $body, $rclass) {

    my ( 
        $rcomments-list,
        $rinline, 
        $rtype, 
        $tags
    ) 
    = rparse-operator-negate($submatch);

    my $rcomment = format-rust-comments($rcomments-list);

    qq:to/END/;
    impl Neg for $rtype \{
        type Output = Self;

        $rcomment
        {$tags}
        {$rinline}fn neg(self) -> Self::Output \{
            {wrap-body-todo($body)}
        \}
    \}
    END

}

use Chomper::Util;
use Chomper::WrapBodyTodo;

our sub translate-op-div($submatch, $body, $rclass) {

    my ( $rcomments-list,
        $rinline, 
        $return-type, 
        $roperand0,
        $roperand1, 
        $tags
    ) 
    = rparse-operator($submatch,$rclass);

    my $rcomment = format-rust-comments($rcomments-list);

    qq:to/END/;
    impl Div<{$roperand1}> for $roperand0 \{

        type Output = $return-type;

        $rcomment
        {$tags}
        {$rinline}fn div(self, other: $roperand1) -> Self::Output \{
            {wrap-body-todo($body)}
        \}
    \}
    END

}


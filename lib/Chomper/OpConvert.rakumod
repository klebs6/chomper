use Chomper::Util;
use Chomper::WrapBodyTodo;

our sub translate-op-convert($submatch, $body, $rclass) {

    my ( $rcomments-list,
            $rinline, 
            $rtype) = 
        rparse-operator-compare($submatch, $rclass);

    my $rcomment       = format-rust-comments($rcomments-list);

    qq:to/END/;
    impl From<{$rtype}> for $rclass \{

        $rcomment
        {$rinline}fn from(other: $rtype) -> Self \{
            {wrap-body-todo($body)}
        \}
    \}
    END
}


use Chomper::Util;
use Chomper::WrapBodyTodo;

sub rparse-operator-not($submatch) {

    #has the same fields
    rparse-operator-into-bool($submatch)
}

our sub translate-operator-not($submatch, $body, $rclass) {

    my (
        $rcomments-list,
        $rinline, 
        $rtype, 
        $tags, 
    ) 
    = rparse-operator-not($submatch);

    my $rcomment       = format-rust-comments($rcomments-list);

    qq:to/END/;
    impl Not for $rclass \{
        type Output = {get-naked($rtype)};

        $rcomment
        {$tags}
        {$rinline}fn not(self) -> Self::Output \{
            {wrap-body-todo($body)}
        \}
    \}
    END
}

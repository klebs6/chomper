use Chomper::Util;
use Chomper::WrapBodyTodo;

sub rparse-operator-indirect($submatch) {

    #has the same fields
    rparse-operator-into-bool($submatch)
}

our sub translate-operator-indirect($submatch, $body, $rclass) {

    my (
        $rcomments-list,
        $rinline, 
        $rtype 
    ) = rparse-operator-indirect($submatch);

    my $rcomment       = format-rust-comments($rcomments-list);

    qq:to/END/;
    impl Deref for $rclass \{
        type Target = {get-naked($rtype)};

        $rcomment
        {$rinline}fn deref(self) -> &Self::Target \{
            {wrap-body-todo($body)}
        \}
    \}
    END
}



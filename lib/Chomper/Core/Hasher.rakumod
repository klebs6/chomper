use util;
use wrap-body-todo;

our sub translate-hasher($submatch, $body, $rclass) {

    my ( $rcomments-list, 
    $roperand0, 
    $rinline) = 
        rparse-hasher($submatch);

    my $rcomment = format-rust-comments($rcomments-list);

    qq:to/END/;
    $rcomment
    impl Hash for $roperand0 \{
        {$rinline}fn hash<H: Hasher>(&self, state: &mut H) \{
            {wrap-body-todo($body)}
        \}
    \}
    END
}

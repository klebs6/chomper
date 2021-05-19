use typemap;
use util;

our sub translate-default-ctor($submatch, $body, $rtype) {

    my ( $rcomments-list ) =
        rparse-default-header($submatch);

    my $rcomment       = format-rust-comments($rcomments-list);

    qq:to/END/;
    impl Default for $rtype \{
        $rcomment
        fn default() -> Self \{
            todo!();
            /*
            {$body.trim.chop.indent(4)}
            */
        \}
    \}
    END
}

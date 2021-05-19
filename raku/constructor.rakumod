use util;

our sub translate-ctor($submatch, $body, $user_rclass) {

    my ( 
        $rtemplate-args, 
        $rclass-name-from-ns, 
        $rfunction-args-list, 
        $rcomments-list ) =
        rparse-ctor-header($submatch);

    my $rcomment       = format-rust-comments($rcomments-list);
    my $rfunction-args = format-rust-function-args($rfunction-args-list);

    my $rclass = 
    $rclass-name-from-ns ?? 
    $rclass-name-from-ns !!
    $user_rclass;

    if $rtemplate-args {

        qq:to/END/;
        impl $rclass \{
            $rcomment
            pub fn new<{$rtemplate-args.join(",")}>({$rfunction-args}) -> Self \{
                todo!();
                /*
                {$body.trim.chomp.indent(4)}
                */
            \}
        \}
        END

    } else {

        qq:to/END/;
        impl $rclass \{
            $rcomment
            pub fn new({$rfunction-args}) -> Self \{
                todo!();
                /*
                {$body.trim.chomp.indent(4)}
                */
            \}
        \}
        END
    }
}

use util;

our sub translate-freestanding-template-function($submatch, $body, $rclass) {

    my ( $rtemplate-args-list, 
            $rcomments-list,
            $rinline, 
            $rreturn-type, 
            $rfunction-name, 
            $rfunction-args-list) = 
        rparse-template-header($submatch);

    my $rcomment       = format-rust-comments($rcomments-list);
    my $rtemplate-args = format-rust-template-args($rtemplate-args-list);
    my $rfunction-args = format-rust-function-args($rfunction-args-list);

    qq:to/END/;
    $rcomment
    {$rinline}pub fn {$rfunction-name}<{$rtemplate-args}>({$rfunction-args}) -> $rreturn-type \{
        todo!();
        /*
        {$body.trim.chomp.indent(4)}
        */
    \}

    END

}

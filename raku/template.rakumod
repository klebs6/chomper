use util;

our sub translate-freestanding-template-function($submatch, $body, $rclass) {

    my ( $rtemplate-args-list, 
            $rcomments-list,
            $rinline, 
            $rreturn-string, 
            $rfunction-name, 
            $rfunction-args-list,
            $option-defaults-initlist,
            $maybe-self-args) = 
        rparse-template-header($submatch);

    my $rcomment       = format-rust-comments($rcomments-list);
    my $rtemplate-args = format-rust-template-args($rtemplate-args-list);
    my $rfunction-args = format-rust-function-args($rfunction-args-list);

    my $optionals      = format-option-defaults-initlist($option-defaults-initlist);

    if $rclass {

        qq:to/END/;
        impl $rclass \{
            $rcomment
            {$rinline}pub fn {$rfunction-name}<{$rtemplate-args}>({$maybe-self-args}{$rfunction-args}) $rreturn-string \{
            {$optionals}
                todo!();
                /*
                {$body.trim.chomp.indent(4)}
                */
            \}
        \}
        END

    } else {

        qq:to/END/;
        $rcomment
        {$rinline}pub fn {$rfunction-name}<{$rtemplate-args}>({$rfunction-args}) $rreturn-string \{
        {$optionals}
            todo!();
            /*
            {$body.trim.chomp.indent(4)}
            */
        \}
        END
    }
}

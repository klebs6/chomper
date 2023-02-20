use Chomper::Util;
use Chomper::Api;
use Chomper::WrapBodyTodo;

our sub translate-freestanding-template-function($submatch, $body, $rclass) {

    my ( 
        $rtemplate-args-list, 
        $rcomments-list,
        $rinline, 
        $rreturn-string, 
        $rfunction-name, 
        $rfunction-args-list,
        $option-defaults-initlist,
        $maybe-self-args, 
        $tags
    ) 
    = rparse-template-header($submatch);

    my Str $api = get-api-tag($submatch<plugin-api>:exists);

    my $rcomment       = format-rust-comments($rcomments-list);
    my $rtemplate-args = format-rust-template-args($rtemplate-args-list);
    my $rfunction-args = format-rust-function-args($rfunction-args-list);

    my $optionals      = format-option-defaults-initlist($option-defaults-initlist);

    if $rclass {

        qq:to/END/;
        impl $rclass \{
            $rcomment
            $api
            {$tags}
            {$rinline}pub fn {$rfunction-name}<{$rtemplate-args}>({$maybe-self-args}{$rfunction-args}) $rreturn-string \{
            {$optionals.trim.chomp.indent(4)}
                {wrap-body-todo($body)}
            \}
        \}
        END

    } else {

        qq:to/END/;
        $rcomment
        $api
        {$tags}
        {$rinline}pub fn {$rfunction-name}<{$rtemplate-args}>({$rfunction-args}) $rreturn-string \{
        {$optionals.trim.chomp.indent(4)}
            {wrap-body-todo($body)}
        \}
        END
    }
}

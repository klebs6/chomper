use util;
use wrap-body-todo;

our sub translate-function($submatch, $body, $rclass) {

    my ( 
        $rinline, 
        $rfunction-name, 
        $return-string, 
        $rfunction-args-list, 
        $roptional-initializers,
        $rmaybe-self-args,
        $rcomments-list ) =
        rparse-function-header($submatch);

    my $rcomment       = format-rust-comments($rcomments-list);
    my $rfunction-args = format-rust-function-args($rfunction-args-list);

    if $rclass {
        #take this branch if we are class function
        qq:to/END/
        impl $rclass \{
            $rcomment
            {$rinline}pub fn {$rfunction-name}({$rmaybe-self-args}{$rfunction-args}) $return-string \{
                {$roptional-initializers}
                {wrap-body-todo($body)}
            \}
        \}
        END
    } else {
        #take this branch if we are freestanding function
        qq:to/END/
        $rcomment
        {$rinline}pub fn {$rfunction-name}({$rfunction-args}) $return-string \{
            {$roptional-initializers}
            {wrap-body-todo($body)}
        \}
        END
    }
}

use Chomper::Util;
use Chomper::WrapBodyTodo;

our sub translate-function($submatch, $body, $rclass) {

    my ( 
        $rinline, 
        $rfunction-name, 
        $return-string, 
        $rfunction-args-list, 
        $roptional-initializers,
        $rmaybe-self-args,
        $rcomments-list,
        $tags
    ) 
    = rparse-function-header($submatch);

    my $rcomment       = format-rust-comments($rcomments-list);
    my $rfunction-args = format-rust-function-args($rfunction-args-list);

    if $rclass {
        #take this branch if we are class function
        qq:to/END/
        impl $rclass \{
            $rcomment
            {$tags}
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
        {$tags}
        {$rinline}pub fn {$rfunction-name}({$rfunction-args}) $return-string \{
            {$roptional-initializers}
            {wrap-body-todo($body)}
        \}
        END
    }
}

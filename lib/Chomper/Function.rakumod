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

    my @optionals = ["", |$roptional-initializers.split("\n")];

    my $rcomment       = format-rust-comments($rcomments-list);
    my $rfunction-args = format-rust-function-args($rfunction-args-list);

    my $nargs = $rfunction-args.split(",").elems;

    if $rclass {

        my $indented-optionals = @optionals.map({ $_.indent(8) }).join("\n");

        if $nargs eq 1 {

            #take this branch if we are class function
            qq:to/END/
            impl $rclass \{
                $rcomment
                {$tags}
                {$rinline}pub fn {$rfunction-name}({$rmaybe-self-args}{$rfunction-args}) $return-string \{
            {$indented-optionals}
                    {wrap-body-todo($body)}
                \}
            \}
            END

        } else {

            my $rmaybe-self = $rmaybe-self-args.trim.chomp;

            my $inner = qq:to/END/.chomp.split("\n").join("\n");
            {$rmaybe-self}{$rfunction-args}
            END

            #take this branch if we are class function
            qq:to/END/
            impl $rclass \{
                $rcomment
                {$tags}
                {$rinline}pub fn {$rfunction-name}(
                    {$inner}

                ) $return-string \{
            {$indented-optionals}
                    {wrap-body-todo($body)}
                \}
            \}
            END

        }

    } else {

        my $indented-optionals = @optionals.map({ $_.indent(4) }).join("\n");

        #take this branch if we are freestanding function
        qq:to/END/
        $rcomment
        {$tags}
        {$rinline}pub fn {$rfunction-name}({$rfunction-args}) $return-string \{
        {$indented-optionals}
            {wrap-body-todo($body)}
        \}
        END
    }
}

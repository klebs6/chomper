use Chomper::Util;
use Chomper::WrapBodyTodo;
use Chomper::Typemap;

our sub translate-destructor( $submatch, $body, $rclass) 
{
    my $type = $submatch<type>.Str;
    qq:to/END/;
    impl Drop for $type \{
        fn drop(&mut self) \{
            {wrap-body-todo($body)}
        \}
    \}
    END
}

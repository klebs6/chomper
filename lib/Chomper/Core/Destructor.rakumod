use util;
use wrap-body-todo;
use typemap;

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

use Chomper::StructMembers;
use Chomper::Case;
use Chomper::FormatName;

our sub translate-full-struct-inner( $submatch, $body, $rclass) {

    my $member-decls = $submatch<struct-member-declarations>;

    my $translated-member-decls = translate-struct-member-declarations($member-decls,$body,$rclass);
    my $struct-name = format-name(~$submatch<struct-name>);

    qq:to/END/;
    pub struct $struct-name \{
    {$translated-member-decls}
    \}
    END
}

our sub translate-full-struct( $submatch, $body, $rclass) 
{
    given $submatch.keys[0] {
        when "full-struct-v1" {
            translate-full-struct-inner($submatch<full-struct-v1>, $body, $rclass)
        }
        when "full-struct-v2" {
            translate-full-struct-inner($submatch<full-struct-v2>, $body, $rclass)
        }
    }
}

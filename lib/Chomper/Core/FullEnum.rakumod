use enum_members;
use case;
use format-name;

our sub translate-full-enum-inner( $submatch, $body, $rclass) {

    my $member-decls = $submatch<enum-member-declarations>;

    my $translated-member-decls = translate-enum-member-declarations($member-decls,$body,$rclass);
    my $enum-name = format-name(~$submatch<enum-name>);

    qq:to/END/;
    pub enum $enum-name \{
    {$translated-member-decls}
    \}
    END
}

our sub translate-full-enum( $submatch, $body, $rclass) 
{
    given $submatch.keys[0] {
        when "full-enum-v1" {
            translate-full-enum-inner($submatch<full-enum-v1>, $body, $rclass)
        }
    }
}

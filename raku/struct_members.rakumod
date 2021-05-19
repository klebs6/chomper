use util;
use typemap;

sub extract-struct-member-data($submatch, $mock = False) {

    if $mock {
        "//test comment", "my_strings: Vec<String>"

    }else {
        get-rcomments-list($submatch),
        get-rust-arg($submatch)
    }
}

sub translate-struct-member-declaration ( $submatch ) {

    my ($comment, $rust-arg) = 
    extract-struct-member-data($submatch);

    qq:to/END/.chomp.trim;
    $comment
    $rust-arg,
    END
}

our sub translate-struct-member-declarations( 
    $submatch, $body, $rclass) 
    {
        my @items = do for 

        $submatch<struct-member-declaration> {
            translate-struct-member-declaration($_)
        };

        @items.join("\n").chomp.trim
    }


use util;
use typemap;
use type-info;

sub extract-struct-member-data($submatch, $mock = False) {

    if $mock {
        "//test comment", "my_strings: Vec<String>", "17"

    }else {
        get-rcomments-list($submatch),
        get-rust-arg($submatch),
        get-default($submatch),
    }
}

our sub get-default($submatch) {
    $submatch<default-value>:exists ?? $submatch<default-value>.Str !! "";
}

our sub make-doc-comment($comment) {
    $comment.lines>>.subst(/\/ \/ <.ws>? <?before <-[/]> > /, "/// ")>>.trim.join("\n")
}

sub translate-struct-member-declaration ( $submatch ) {

    my ($comment, $rust-arg, $default) = 
    extract-struct-member-data($submatch);

    $comment = make-doc-comment($comment).chomp.trim;

    my $default-tag = $default ?? " // default = $default" !! "";

    if $comment {
        qq:to/END/.trim-trailing;

        $comment
        $rust-arg,$default-tag
        END
    } else {
        qq:to/END/.chomp.trim;
        $rust-arg,$default-tag
        END
    }
}

our sub translate-struct-member-declarations( $submatch, $body, $rclass) 
{
    my @items = do for 

    $submatch<struct-member-declaration> {
        translate-struct-member-declaration($_)
    };

    @items.join("\n").chomp.trim
}


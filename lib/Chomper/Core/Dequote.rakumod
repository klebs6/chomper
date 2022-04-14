use quoted-string-token;

our sub dequote($input) {

    grammar Quoted does QuotedStringToken {
        token TOP  { <quoted-string> }
    }

    my $parsed = Quoted.parse($input);

    if $parsed {
        ~$parsed<quoted-string><quoted-string-body>
    } else {
        $input
    }
}


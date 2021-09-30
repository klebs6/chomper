
our sub translate-simple-ifdef( $submatch, $body, $rclass) {

    my $id = $submatch<identifier>.Str;

    if $submatch<ifdef>:exists {
        "#[cfg($id)]"

    } else { #ifndef

        "#[cfg(not($id))]"
    }
}

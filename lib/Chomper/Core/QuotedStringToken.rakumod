our role QuotedStringToken {

    token opening-quote {
        | \"
        | "'"
    }

    token closing-quote {
        | \"
        | "'"
    }

    token quoted-string-body {
        [
            <-[ ' " \\ ]>  # regular character
            | \\ .         # escape sequence
        ]*
    }

    token quoted-string {
        <.opening-quote>
        <quoted-string-body>
        <.closing-quote>
    }
}

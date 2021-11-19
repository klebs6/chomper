our role QuotedStringToken {

    token opening-quote {
        | \"
        | "'"
    }

    token closing-quote {
        | \"
        | "'"
    }

    token quoted-string {
        <.opening-quote>
        [
            <-[ ' " \\ ]>  # regular character
            | \\ .         # escape sequence
        ]*
        <.closing-quote>
    }
}

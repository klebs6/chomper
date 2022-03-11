our role ByteStringLiteral::Rules {

    token byte-string-literal {
        b <tok-double-quote> 
        [
            | <ascii-for-string>
            | <byte-escape>
            | <string-continue>
        ]* 
        <tok-double-quote>
    }

    token raw-byte-string-literal {
        br <raw-byte-string-content>
    }

    proto token raw-byte-string-content { * }

    token raw-byte-string-content:sym<a> {
        <tok-double-quote> 
        <ascii>*? 
        <tok-double-quote>
    }

    token raw-byte-string-content:sym<b> {
        <tok-pound> 
        <raw-byte-string-content>
        <tok-pound>
    }
}

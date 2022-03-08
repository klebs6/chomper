our role LiteralExpression::Rules {

    proto rule literal-expression { * }

    rule literal-expression:sym<char> {
        <char-literal>
    }

    rule literal-expression:sym<str> {
        <string-literal>
    }

    rule literal-expression:sym<raw-str> {
        <raw-string-literal>
    }

    rule literal-expression:sym<byte> {
        <byte-literal>
    }

    rule literal-expression:sym<byte-str> {
        <byte-string-literal>
    }

    rule literal-expression:sym<raw-byte-str> {
        <raw-byte-string-literal>
    }

    rule literal-expression:sym<int> {
        <integer-literal>
    }

    rule literal-expression:sym<float> {
        <float-literal>
    }

    rule literal-expression:sym<bool> {
        <boolean-literal>
    }
}

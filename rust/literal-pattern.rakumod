our role LiteralPattern::Rules {

    proto rule literal-pattern { * }

    rule literal-pattern:sym<bool> {  
        <boolean-literal>
    }

    rule literal-pattern:sym<char> {  
        <char-literal>
    }

    rule literal-pattern:sym<byte> {  
        <byte-literal>
    }

    rule literal-pattern:sym<str> {  
        <string-literal>
    }

    rule literal-pattern:sym<raw-str> {  
        <raw-string-literal>
    }

    rule literal-pattern:sym<byte-str> {  
        <byte-string-literal>
    }

    rule literal-pattern:sym<raw-byte-str> {  
        <raw-byte-string-literal>
    }

    rule literal-pattern:sym<int> {  
        <tok-minus>? <integer-literal>
    }

    rule literal-pattern:sym<float> {  
        <tok-minus>? <float-literal>
    }
}
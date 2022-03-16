use Data::Dump::Tree;

our class ByteStringLiteral {
    has $.value;

    has $.text;

    submethod TWEAK {
        say self.gist;
    }

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

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

our role ByteStringLiteral::Actions {
    method byte-string-literal($/) {
        make ByteStringLiteral.new(
            value => $/.Str,
        )
    }
}

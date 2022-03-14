our class LiteralPattern {
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

our role LiteralPattern::Rules {

    proto rule literal-pattern { * }

    rule literal-pattern:sym<bool>         { <boolean-literal> }
    rule literal-pattern:sym<char>         { <char-literal> }
    rule literal-pattern:sym<byte>         { <byte-literal> }
    rule literal-pattern:sym<str>          { <string-literal> }
    rule literal-pattern:sym<raw-str>      { <raw-string-literal> }
    rule literal-pattern:sym<byte-str>     { <byte-string-literal> }
    rule literal-pattern:sym<raw-byte-str> { <raw-byte-string-literal> }
    rule literal-pattern:sym<int>          { <tok-minus>? <integer-literal> }
    rule literal-pattern:sym<float>        { <tok-minus>? <float-literal> }
}

our role LiteralPattern::Actions {

    method literal-pattern:sym<bool>($/)         { <boolean-literal> }
    method literal-pattern:sym<char>($/)         { <char-literal> }
    method literal-pattern:sym<byte>($/)         { <byte-literal> }
    method literal-pattern:sym<str>($/)          { <string-literal> }
    method literal-pattern:sym<raw-str>($/)      { <raw-string-literal> }
    method literal-pattern:sym<byte-str>($/)     { <byte-string-literal> }
    method literal-pattern:sym<raw-byte-str>($/) { <raw-byte-string-literal> }
    method literal-pattern:sym<int>($/)          { <tok-minus>? <integer-literal> }
    method literal-pattern:sym<float>($/)        { <tok-minus>? <float-literal> }
}

our class NumericLiteral {
    has Bool $.minus;
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

    method literal-pattern:sym<bool>($/)         { make $<boolean-literal>.made }
    method literal-pattern:sym<char>($/)         { make $<char-literal>.made }
    method literal-pattern:sym<byte>($/)         { make $<byte-literal>.made }
    method literal-pattern:sym<str>($/)          { make $<string-literal>.made }
    method literal-pattern:sym<raw-str>($/)      { make $<raw-string-literal>.made }
    method literal-pattern:sym<byte-str>($/)     { make $<byte-string-literal>.made }
    method literal-pattern:sym<raw-byte-str>($/) { make $<raw-byte-string-literal>.made }

    method integer-literal-pattern($/) { 
        make NumericLiteral.new(
            minus => so $/<tok-minus>:exists,
            value => $<integer-literal>.made,
            text       => $/.Str,
        )
    }

    method float-literal-pattern($/) { 
        make NumericLiteral.new(
            minus => so $/<tok-minus>:exists,
            value => $<float-literal>.made,
            text       => $/.Str,
        )
    }

    method literal-pattern:sym<int>($/) { 
        make $<integer-literal-pattern>.made
    }

    method literal-pattern:sym<float>($/) { 
        make $<float-literal-pattern>.made
    }
}

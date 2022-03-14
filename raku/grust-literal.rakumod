our class LiteralExpression {
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

our role LiteralExpression::Rules {

    proto token literal-expression { * }
    token literal-expression:sym<char>         { <char-literal>            } 
    token literal-expression:sym<str>          { <string-literal>          } 
    token literal-expression:sym<raw-str>      { <raw-string-literal>      } 
    token literal-expression:sym<byte>         { <byte-literal>            } 
    token literal-expression:sym<byte-str>     { <byte-string-literal>     } 
    token literal-expression:sym<raw-byte-str> { <raw-byte-string-literal> } 
    token literal-expression:sym<int>          { <integer-literal>         } 
    token literal-expression:sym<float>        { <float-literal>           } 
    token literal-expression:sym<bool>         { <boolean-literal>         } 
}

our role LiteralExpression::Actions {}

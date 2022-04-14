use Data::Dump::Tree;

use grust-float-literal;
use grust-int-literal;

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

our role LiteralExpression::Actions {

    method literal-expression:sym<char>($/)         { make $<char-literal>.made            } 
    method literal-expression:sym<str>($/)          { make $<string-literal>.made          } 
    method literal-expression:sym<raw-str>($/)      { make $<raw-string-literal>.made      } 
    method literal-expression:sym<byte>($/)         { make $<byte-literal>.made            } 
    method literal-expression:sym<byte-str>($/)     { make $<byte-string-literal>.made     } 
    method literal-expression:sym<raw-byte-str>($/) { make $<raw-byte-string-literal>.made } 

    method literal-expression:sym<int>($/) { 
        make IntegerLiteral.new( value => ~$/)
    } 

    method literal-expression:sym<float>($/) { 
        make FloatLiteral.new( value => $/.Str) 
    }

    method literal-expression:sym<bool>($/)         { make $<boolean-literal>.made         } 
}

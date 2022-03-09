our role Visibility::Rules {
    proto rule visibility { * }

    rule visibility:sym<basic>   { <kw-pub> }
    rule visibility:sym<crate>   { <kw-pub> <tok-lparen> <kw-crate> <tok-rparen> }
    rule visibility:sym<self>    { <kw-pub> <tok-lparen> <kw-self>  <tok-rparen> }
    rule visibility:sym<super>   { <kw-pub> <tok-lparen> <kw-super> <tok-rparen> }
    rule visibility:sym<in-path> { <kw-pub> <tok-lparen> <kw-in> <simple-path> <tok-rparen> }
}

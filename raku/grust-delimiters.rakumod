our role Delimiters::Rules {

    token tok-lparen { '(' }
    token tok-rparen { ')' }

    token tok-lbrace { '{' }
    token tok-rbrace { '}' }

    token tok-lbrack { '[' }
    token tok-rbrack { ']' }

    proto token delimiter { * }
    token delimiter:sym<lparen> { <tok-lparen> }
    token delimiter:sym<rparen> { <tok-rparen> }
    token delimiter:sym<lbrace> { <tok-lbrace> }
    token delimiter:sym<rbrace> { <tok-rbrace> }
    token delimiter:sym<lbrack> { <tok-lbrack> }
    token delimiter:sym<rbrack> { <tok-rbrack> }
}

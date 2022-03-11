our role MetaItem::Rules {

    proto rule meta-item { * }

    rule meta-item:sym<simple> {  
        <simple-path>
    }

    rule meta-item:sym<simple-eq-expr> {  
        <simple-path> <tok-eq> <expression>
    }

    rule meta-item:sym<simple-with-meta-seq> {  
        <simple-path> <tok-lparen> <meta-seq>? <tok-rparen>
    }

    rule meta-seq {
        <meta-item-inner>+ %% <tok-comma>
    }

    #---------------
    proto rule meta-item-inner { * }

    rule meta-item-inner:sym<basic> { <meta-item> }

    rule meta-item-inner:sym<expr>  { <expression> }

    rule meta-word {
        <identifier>
    }

    #---------------
    proto rule any-string-literal { * }

    rule any-string-literal:sym<basic> { <string-literal> }
    rule any-string-literal:sym<raw>   { <raw-string-literal> }

    #---------------
    rule meta-name-value-str {
        <identifier> <tok-eq> <any-string-literal>
    }

    rule meta-list-paths {
        <identifier> 
        <tok-lparen>
        [ <simple-path>* %% <tok-comma> ] 
        <tok-rparen>
    }

    rule meta-list-idents {
        <identifier>
        <tok-lparen>
        [ <identifier>* %% <tok-comma> ]
        <tok-rparen>
    }

    rule meta-list-name-value-str {
        <identifier>
        <tok-lparen>
        [ <meta-name-value-str>* %% <tok-comma> ]
        <tok-rparen>
    }
}

our role MetaItem::Actions {}

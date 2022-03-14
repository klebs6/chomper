our class MetaItemSimple {
    has $.simple-path;

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

our class MetaItemSimpleEqExpr {
    has $.simple-path;
    has $.expression;

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

our class MetaItemSimpleWithMetaSeq {
    has $.simple-path;
    has $.meta-seq;

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

our class MetaSeq {
    has @.meta-items;

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

our class MetaWord {
    has $.identifier;

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

our class MetaNameValueStr {
    has $.identifier;
    has $.any-string-literal;

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

our class MetaListPaths {
    has $.identifier;
    has @.simple-paths;

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

our class MetaListIdents {
    has $.identifier;
    has @.grouped-identifiers;

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

our class MetaListNameValueStr {
    has $.identifier;
    has @.grouped-meta-name-value-str;

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

our role MetaItem::Actions {

    method meta-item:sym<simple>($/) {  
        <simple-path>
    }

    method meta-item:sym<simple-eq-expr>($/) {  
        <simple-path> <tok-eq> <expression>
    }

    method meta-item:sym<simple-with-meta-seq>($/) {  
        <simple-path> <tok-lparen> <meta-seq>? <tok-rparen>
    }

    method meta-seq($/) {
        <meta-item-inner>+ %% <tok-comma>
    }

    #---------------
    method meta-item-inner:sym<basic>($/) { <meta-item> }

    method meta-item-inner:sym<expr>($/)  { <expression> }

    method meta-word($/) {
        <identifier>
    }

    #---------------
    method any-string-literal:sym<basic>($/) { <string-literal> }
    method any-string-literal:sym<raw>($/)   { <raw-string-literal> }

    #---------------
    method meta-name-value-str($/) {
        <identifier> <tok-eq> <any-string-literal>
    }

    method meta-list-paths($/) {
        <identifier> 
        <tok-lparen>
        [ <simple-path>* %% <tok-comma> ] 
        <tok-rparen>
    }

    method meta-list-idents($/) {
        <identifier>
        <tok-lparen>
        [ <identifier>* %% <tok-comma> ]
        <tok-rparen>
    }

    method meta-list-name-value-str($/) {
        <identifier>
        <tok-lparen>
        [ <meta-name-value-str>* %% <tok-comma> ]
        <tok-rparen>
    }
}

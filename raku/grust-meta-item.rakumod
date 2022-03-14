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

    rule ident-list {
        <identifier>* %% <tok-comma>
    }

    rule meta-list-idents {
        <identifier>
        <tok-lparen>
        <ident-list>
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
        make MetaItemSimple.new(
            simple-path => $<simple-path>.made
        )
    }

    method meta-item:sym<simple-eq-expr>($/) {  
        make MetaItemSimpleEqExpr.new(
            simple-path => $<simple-path>.made,
            expression => $<expression>.made,
        )
    }

    method meta-item:sym<simple-with-meta-seq>($/) {  
        make MetaItemSimpleWithMetaSeq.new(
            simple-path => $<simple-path>.made,
            meta-seq    => $<meta-seq>.made,
        )
    }

    method meta-seq($/) {
        make $<meta-item-inner>>>.made
    }

    #---------------
    method meta-item-inner:sym<basic>($/) { make $<meta-item>.made }

    method meta-item-inner:sym<expr>($/)  { make $<expression>.made }

    method meta-word($/) {
        make $<identifier>.made
    }

    #---------------
    method any-string-literal:sym<basic>($/) { make $<string-literal>.made }
    method any-string-literal:sym<raw>($/)   { make $<raw-string-literal>.made }

    #---------------
    method meta-name-value-str($/) {
        make MetaNameValueStr.new(
            identifier         => $<identifier>.made,
            any-string-literal => $<any-string-literal>.made,
        )
    }

    method meta-list-paths($/) {
        make MetaListPaths.new(
            identifier   => $<identifier>.made,
            simple-paths => $<simple-path>>>.made,
        )
    }

    method ident-list($/) {
        make $<identifier>>>.made
    }

    method meta-list-idents($/) {
        make MetaListIdents.new(
            identifier          => $<identifier>.made,
            grouped-identifiers => $<ident-list>.made,
        )
    }

    method meta-list-name-value-str($/) {
        make MetaListNameValueStr.new(
            identifier                  => $<identifier>.made,
            grouped-meta-name-value-str => $<meta-name-value-str>>>.made,
        )
    }
}

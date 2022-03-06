use Data::Dump::Tree;

#-------------------------------------
# the braces-delimited macro is a block-expr so it
# doesn't appear here
our class MacroExpr {
    has $.path-expr;
    has $.parens-delimited-token-trees;
    has $.maybe-ident;
    has $.brackets-delimited-token-trees;

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

our role MacroExpr::Rules {

    proto rule macro-expr { * }

    rule macro-expr:sym<a> {
        <path-expr> 
        <tok-bang>
        <maybe-ident> 
        <parens-delimited-token-trees>
    }

    rule macro-expr:sym<b> {
        <path-expr> 
        <tok-bang>
        <maybe-ident> 
        <brackets-delimited-token-trees>
    }
}

our role MacroExpr::Actions {

    method macro-expr:sym<a>($/) {
        make MacroExpr.new(
            path-expr                    => $<path-expr>.made,
            maybe-ident                  => $<maybe-ident>.made,
            parens-delimited-token-trees => $<parens-delimited-token-trees>.made,
            text                         => ~$/,
        )
    }

    method macro-expr:sym<b>($/) {
        make MacroExpr.new(
            path-expr                      => $<path-expr>.made,
            maybe-ident                    => $<maybe-ident>.made,
            brackets-delimited-token-trees => $<brackets-delimited-token-trees>.made,
            text                           => ~$/,
        )
    }
}

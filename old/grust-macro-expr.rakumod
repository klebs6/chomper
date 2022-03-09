use Data::Dump::Tree;

#-------------------------------------
# the braces-delimited macro is a block-expr so it
# doesn't appear here
our class MacroExpr {
    has $.path-expr;
    has $.maybe-ident;
    has $.parens-delimited-token-trees;
    has $.brackets-delimited-token-trees;

    has $.text;

    method gist {
        my $path   = $.path-expr.gist;

        my $has-ident = so $.maybe-ident;

        my $ident = $has-ident ?? $.maybe-ident.gist !! "";

        my $parens    = so $.parens-delimited-token-trees;
        my $brack     = so $.brackets-delimited-token-trees;

        my $p = $.parens-delimited-token-trees>>.gist.join("");
        my $b = $.brackets-delimited-token-trees>>.gist.join("");

        if $parens {
            $path 
            ~ "!" 
            ~ $ident
            ~ "(" 
            ~ $p
            ~ ")"

        } elsif $brack {
            $path 
            ~ "!" 
            ~ $ident
            ~ "[" 
            ~ $b
            ~ "]"
        } else {
            $path 
            ~ "!" 
            ~ $ident
            ~ "[]" 
        }
    }
}

our role MacroExpr::Rules {

    proto rule macro-expr { * }

    rule macro-expr:sym<parens> {
        <path-expr> 
        <tok-bang>
        <maybe-ident> 
        <parens-delimited-token-trees>
    }

    rule macro-expr:sym<brack> {
        <path-expr> 
        <tok-bang>
        <maybe-ident> 
        <brackets-delimited-token-trees>
    }
}

our role MacroExpr::Actions {

    method macro-expr:sym<parens>($/) {
        make MacroExpr.new(
            path-expr                    => $<path-expr>.made,
            maybe-ident                  => $<maybe-ident>.made,
            parens-delimited-token-trees => $<parens-delimited-token-trees>.made,
            text                         => ~$/,
        )
    }

    method macro-expr:sym<brack>($/) {
        make MacroExpr.new(
            path-expr                      => $<path-expr>.made,
            maybe-ident                    => $<maybe-ident>.made,
            brackets-delimited-token-trees => $<brackets-delimited-token-trees>.made,
            text                           => ~$/,
        )
    }
}

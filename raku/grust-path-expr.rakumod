our class SelfPath {
    has $.path-generic-args-with-colons;

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

#-------------------------------------

our role PathExpr::Rules {

    rule path-expr { 
        [ <kw-self>? <tok-mod-sep> ]?
        <path-generic-args-with-colons> 
    }
}

our role PathExpr::Actions {

    method path-expr($/) {
        if $/<kw-self>:exists {
            make SelfPath.new(
                path-generic-args-with-colons => $<path-generic-args-with-colons>.made,
                text                          => ~$/,
            )
        } else {
            make $<path-generic-args-with-colons>.made
        }
    }
}

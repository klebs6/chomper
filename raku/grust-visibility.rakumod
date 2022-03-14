our class VisibilityPublic { 

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

our class VisibilityCrate  { 

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

our class VisibilitySelf   { 

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

our class VisibilitySuper  { 

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

our class VisibilityInPath {
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

our role Visibility::Rules {
    proto rule visibility { * }

    rule visibility:sym<basic>   { <kw-pub> }
    rule visibility:sym<crate>   { <kw-pub> <tok-lparen> <kw-crate> <tok-rparen> }
    rule visibility:sym<self>    { <kw-pub> <tok-lparen> <kw-selfvalue>  <tok-rparen> }
    rule visibility:sym<super>   { <kw-pub> <tok-lparen> <kw-super> <tok-rparen> }
    rule visibility:sym<in-path> { <kw-pub> <tok-lparen> <kw-in> <simple-path> <tok-rparen> }
}

our role Visibility::Actions {

    method visibility:sym<basic>($/)   { <kw-pub> }
    method visibility:sym<crate>($/)   { <kw-pub> <tok-lparen> <kw-crate> <tok-rparen> }
    method visibility:sym<self>($/)    { <kw-pub> <tok-lparen> <kw-selfvalue>  <tok-rparen> }
    method visibility:sym<super>($/)   { <kw-pub> <tok-lparen> <kw-super> <tok-rparen> }
    method visibility:sym<in-path>($/) { <kw-pub> <tok-lparen> <kw-in> <simple-path> <tok-rparen> }
}

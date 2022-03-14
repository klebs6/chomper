our class WhereClause {
    has @.where-clause-items;

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

our class WhereClauseItemLifetime {
    has $.lifetime;
    has $.lifetime-bounds;

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

our class WhereClauseItemTypeBound {
    has $.maybe-for-lifetimes;
    has $.type;
    has $.maybe-type-param-bounds;

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
our role WhereClause::Rules {

    rule where-clause {
        <kw-where>
        [<where-clause-item>* %% <tok-comma>]
    }

    proto rule where-clause-item { * }

    rule where-clause-item:sym<lt> {
        <lifetime> 
        <tok-colon> 
        <lifetime-bounds>
    }

    rule where-clause-item:sym<type-bound> {
        <for-lifetimes>? 
        <type> 
        <tok-colon> 
        <type-param-bounds>?
    }
}

our role WhereClause::Actions {}

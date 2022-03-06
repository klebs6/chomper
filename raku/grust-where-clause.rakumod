use Data::Dump::Tree;

our class WhereClause {
    has $.where-predicates;

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

    rule maybe-where-clause { <where-clause>? }
    rule where-clause       { <kw-where> <where-predicates> ','? }
}

our role WhereClause::Actions {

    method maybe-where-clause($/) {
        make $<where-clause>.made
    }

    method where-clause($/) {
        make WhereClause.new(
            where-predicates => $<where-predicates>.made,
            text             => ~$/,
        )
    }
}

our class WhereClause {
    has $.where_predicates;
}

our class WhereClause::Rules {

    proto rule maybe-where_clause { * }

    rule maybe-where_clause:sym<a> {

    }

    rule maybe-where_clause:sym<b> {
        <where-clause>
    }

    proto rule where-clause { * }

    rule where-clause:sym<a> {
        <WHERE> <where-predicates>
    }

    rule where-clause:sym<b> {
        <WHERE> <where-predicates> ','
    }
}

our class WhereClause::Actions {

    method maybe-where_clause:sym<a>($/) {
        MkNone<140613549527104>
    }

    method maybe-where_clause:sym<b>($/) {
        make $<where-clause>.made
    }

    method where-clause:sym<a>($/) {
        make WhereClause.new(
            where-predicates =>  $<where-predicates>.made,
        )
    }

    method where-clause:sym<b>($/) {
        make WhereClause.new(
            where-predicates =>  $<where-predicates>.made,
        )
    }
}

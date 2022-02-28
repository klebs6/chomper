use grust-model;

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
            where-predicates =>  $<where-predicates>.made,
        )
    }
}

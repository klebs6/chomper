use grust-model;

our role WherePredicates::Rules {

    rule where-predicates {
        <where-predicate>+ %% ","
    }

    proto rule where-predicate { * }

    rule where-predicate:sym<a> {
        <maybe-for-lifetimes> <lifetime> ':' <bounds>
    }

    rule where-predicate:sym<b> {
        <maybe-for-lifetimes> <ty> ':' <ty-param-bounds>
    }
}

our role WherePredicates::Actions {

    method where-predicates($/) {
        make $<where-predicate>>>.made
    }

    method where-predicate:sym<a>($/) {
        make WherePredicate.new(
            maybe-for-lifetimes =>  $<maybe-for-lifetimes>.made,
            lifetime            =>  $<lifetime>.made,
            bounds              =>  $<bounds>.made,
        )
    }

    method where-predicate:sym<b>($/) {
        make WherePredicate.new(
            maybe-for-lifetimes =>  $<maybe-for-lifetimes>.made,
            ty                  =>  $<ty>.made,
            ty-param-bounds     =>  $<ty-param-bounds>.made,
        )
    }
}


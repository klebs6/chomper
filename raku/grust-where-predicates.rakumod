our class WherePredicate {
    has $.maybe_for_lifetimes;
    has $.bounds;
    has $.lifetime;
    has $.ty_param_bounds;
    has $.ty;
}

our class WherePredicates {
    has $.where_predicate;
}

our class WherePredicates::G {

    proto rule where-predicates { * }

    rule where-predicates:sym<a> {
        <where-predicate>
    }

    rule where-predicates:sym<b> {
        <where-predicates> ',' <where-predicate>
    }

    proto rule where-predicate { * }

    rule where-predicate:sym<a> {
        <maybe-for_lifetimes> <lifetime> ':' <bounds>
    }

    rule where-predicate:sym<b> {
        <maybe-for_lifetimes> <ty> ':' <ty-param_bounds>
    }
}

our class WherePredicates::A {

    method where-predicates:sym<a>($/) {
        make WherePredicates.new(
            where-predicate =>  $<where-predicate>.made,
        )
    }

    method where-predicates:sym<b>($/) {
        ExtNode<140202784484832>
    }

    method where-predicate:sym<a>($/) {
        make WherePredicate.new(
            maybe-for_lifetimes =>  $<maybe-for_lifetimes>.made,
            lifetime            =>  $<lifetime>.made,
            bounds              =>  $<bounds>.made,
        )
    }

    method where-predicate:sym<b>($/) {
        make WherePredicate.new(
            maybe-for_lifetimes =>  $<maybe-for_lifetimes>.made,
            ty                  =>  $<ty>.made,
            ty-param_bounds     =>  $<ty-param_bounds>.made,
        )
    }
}

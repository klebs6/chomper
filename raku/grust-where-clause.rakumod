our role WhereClause::Rules {

    rule where-clause {
        <kw-where>
        [<where-clause-item>* %% <tok-comma>]
    }

    proto rule where-clause-item { * }

    rule where-clause-item:sym<lt> {
        <lifetime-where-clause-item>
    }

    rule where-clause-item:sym<type-bound> {
        <type-bound-where-clause-item>
    }

    rule lifetime-where-clause-item {
        <lifetime> 
        <tok-colon> 
        <lifetime-bounds>
    }

    rule type-bound-where-clause-item {
        <for-lifetimes>? 
        <type> 
        <tok-colon> 
        <type-param-bounds>?
    }
}

our role WhereClause::Actions {}

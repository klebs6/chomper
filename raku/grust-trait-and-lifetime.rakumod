our role TypeBounds::Rules {

    rule type-param-bounds {
        <type-param-bound>+ %% <tok-plus>
    }

    proto rule type-param-bound { * }
    rule type-param-bound:sym<lt> { <lifetime> }
    rule type-param-bound:sym<tb> { <trait-bound> }

    proto rule trait-bound { * }

    rule trait-bound:sym<no-parens> { 
        <tok-qmark-qmark> 
        <for-lifetimes>? 
        <type-path> 
    }

    rule trait-bound:sym<parens> { 
        <tok-lparen> 
        <tok-qmark-qmark> 
        <for-lifetimes>? 
        <type-path> 
        <tok-rparen> 
    }

    rule lifetime-bounds {
        <lifetime>* %% <tok-plus>
    }

    proto token lifetime { * }
    token lifetime:sym<lt>      { <lifetime-or-label> }
    token lifetime:sym<static>  { \' <static> }
    token lifetime:sym<unnamed> { \' _ }

    rule for-lifetimes {
        <kw-for> <generic-params>
    }
}

our role TypeBounds::Actions {}

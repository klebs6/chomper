our role GenericArgs::Rules {

    rule type-param-bounds {
        <type-param-bound>+ %% <tok-plus>
    }

    proto rule type-param-bound { * }
    rule type-param-bound:sym<lt> { <lifetime> }
    rule type-param-bound:sym<tb> { <trait-bound> }

    proto rule trait-bound { * }

    rule trait-bound:sym<no-parens> { 
        <tok-qmark>?
        <for-lifetimes>? 
        <type-path> 
    }

    rule trait-bound:sym<parens> { 
        <tok-lparen> 
        <tok-qmark>?
        <for-lifetimes>? 
        <type-path> 
        <tok-rparen> 
    }

    rule generic-args {
        <tok-lt>
        [ <generic-arg>* %% <tok-comma> ]
        <tok-gt>
    }

    proto rule generic-arg { * }

    rule generic-arg:sym<lifetime>             { <lifetime> }
    rule generic-arg:sym<generic-args-binding> { <generic-args-binding> }
    rule generic-arg:sym<type>                 { <type> }
    rule generic-arg:sym<generic-args-const>   { <generic-args-const> }

    proto rule generic-args-const                    { * }
    rule generic-args-const:sym<block>               { <block-expression> }
    rule generic-args-const:sym<lit>                 { <literal-expression> }
    rule generic-args-const:sym<minus-lit>           { <tok-minus> <literal-expression> }
    rule generic-args-const:sym<simple-path-segment> { <simple-path-segment> }

    rule generic-args-binding {
        <identifier> <tok-eq> <type>
    }
}

our role GenericArgs::Actions {}

our role GenericArgs {

    rule generic-args {
        <tok-lt>
        [ <generic-arg>* %% <tok-comma> ]
        <tok-rt>
    }

    proto rule generic-arg { * }

    rule generic-arg:sym<lifetime>             { <lifetime> }
    rule generic-arg:sym<type>                 { <type> }
    rule generic-arg:sym<generic-args-const>   { <generic-args-const> }
    rule generic-arg:sym<generic-args-binding> { <generic-args-binding> }

    proto rule generic-args-const                    { * }
    rule generic-args-const:sym<block>               { <block-expression> }
    rule generic-args-const:sym<lit>                 { <literal-expression> }
    rule generic-args-const:sym<minus-lit>           { <tok-minus> <literal-expression> }
    rule generic-args-const:sym<simple-path-segment> { <simple-path-segment> }

    rule generic-args-binding {
        <identifier> <tok-eq> <type>
    }
}

our role TypePath::Rules {

    rule type-path {
        <tok-path-sep>?
        [ <type-path-segment>+ %% <tok-path-sep> ]
    }

    rule type-path-segment { 
        <path-ident-segment> 
        [
            <tok-path-sep>?
            <type-path-segment-suffix>
        ]?
    }

    #----------------------
    proto rule type-path-segment-suffix { * }

    rule type-path-segment-suffix:sym<generic> {  
        <generic-args>
    }

    rule type-path-segment-suffix:sym<type-path-fn> {  
        <type-path-fn>
    }

    rule type-path-fn {
        <tok-lparen> 
        <type-path-fn-inputs>? 
        <tok-rparen> 
        [ <tok-rarrow> <type> ]?
    }

    rule type-path-fn-inputs {
        <type>+ %% <tok-comma>
    }
}

our role TypePath::Actions {}

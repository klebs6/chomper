our role TypePath::Rules {

    rule type-path {
        <tok-mod-sep>?
        [ <type-path-segment>+ %% <tok-mod-sep> ]
    }

    rule type-path-segment { 
        <path-ident-segment> <tok-mod-sep>? <type-path-segment-suffix>?
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

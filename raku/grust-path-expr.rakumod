use grust-model;

#-------------------------------------

our role PathExpr::Rules {

    rule path-expr { 
        [ <kw-self>? <tok-mod-sep> ]?
        <path-generic-args-with-colons> 
    }
}

our role PathExpr::Actions {

    method path-expr($/) {
        if $/<kw-self>:exists {
            make SelfPath.new(
                path-generic-args-with-colons =>  $<path-generic-args-with-colons>.made,
            )
        } else {
            make $<path-generic-args-with-colons>.made
        }
    }
}

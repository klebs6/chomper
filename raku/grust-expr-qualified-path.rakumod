use grust-model;

our role ExprQualifiedPath::Rules {

    proto rule expr-qualified-path { * }

    rule expr-qualified-path:sym<a> {
        '<' 
        <ty-sum> 
        <maybe-as-trait-ref> 
        '>' 
        <tok-mod-sep> 
        <ident> 
        <maybe-qpath-params>
    }

    rule expr-qualified-path:sym<e> {
        <tok-shl> 
        <ty-sum> 
        <maybe-as-trait-ref> 
        '>' 
        <tok-mod-sep> 
        <ident> 
        <generic-args>?
        <maybe-as-trait-ref> 
        '>' 
        <tok-mod-sep> 
        <ident> 
        <generic-args>?
    }
}

our role ExprQualifiedPath::Actions {

    method expr-qualified-path:sym<a>($/) {
        make ExprQualifiedPath.new(
            ty-sum              =>  $<ty-sum>.made,
            maybe-as-trait-ref0 =>  $<maybe-as-trait-ref>.made,
            identA              =>  $<ident>.made,
            maybe-qpath-params  =>  $<maybe-qpath-params>.made,
        )
    }

    method expr-qualified-path:sym<e>($/) {
        make ExprQualifiedPath.new(
            ty-sum              =>  $<ty-sum>.made,
            maybe-as-trait-ref0 =>  $<maybe-as-trait-ref>>>.made[0],

            identA              =>  $<ident>>>.made[0],
            generic-argsA       =>  $<generic-args>>>.made[0],
            maybe-as-trait-ref1 =>  $<maybe-as-trait-ref>>>.made[1],

            identB              =>  $<ident>>>.made[1],
            generic-argsB       =>  $<generic-args>>>.made[1],
        )
    }
}

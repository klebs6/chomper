use grust-model;

our role PathNoTypesAllowed::Rules {

    proto rule path-no-types-allowed-base { * }

    rule path-no-types-allowed-base:sym<a> { <ident> }
    rule path-no-types-allowed-base:sym<b> { <tok-mod-sep>? <kw-self> }
    rule path-no-types-allowed-base:sym<c> { <tok-mod-sep>? <kw-super> }

    rule path-no-types-allowed {  
        <tok-mod-sep>? #i added this here so we could parse things scoped globally

        <path-no-types-allowed-base> 
        [<tok-mod-sep> <ident>]*
    }
}

our role PathNoTypesAllowed::Actions {

    method path-no-types-allowed($/) {
        make ViewPath.new(
            base =>  $<path-no-types-allowed-base>.made,
            tail =>  $<ident>>>.made,
        )
    }

    method path-no-types-allowed-base:sym<a>($/) { make $<ident>.made }
    method path-no-types-allowed-base:sym<b>($/) { make $<kw-self>.made }
    method path-no-types-allowed-base:sym<c>($/) { make $<kw-super>.made }
}

our role PathGenericArgsWithoutColons::Rules {

    rule path-generic-args-without-colons {  
        #{self.set-prec(IDENT)}
        <path-generic-args-without-colons-item>+ %% <tok-mod-sep>
    }

    proto rule path-generic-args-without-colons-item { * }

    rule path-generic-args-without-colons-item:sym<c>  { <ident> '(' <maybe-ty-sums> ')' <ret-ty> }
    token path-generic-args-without-colons-item:sym<b> { <ident> <tok-mod-sep>? <generic-args> }
    token path-generic-args-without-colons-item:sym<a> { <ident> }
}

our role PathGenericArgsWithoutColons::Actions {

    method path-generic-args-without-colons($/) {
        make $<path-generic-args-without-colons-item>>>.made
    }

    method path-generic-args-without-colons-item:sym<a>($/) {
        make Components.new(
            ident =>  $<ident>.made,
        )
    }

    method path-generic-args-without-colons-item:sym<b>($/) {
        make Components.new(
            ident        =>  $<ident>.made,
            generic-args =>  $<generic-args>.made,
        )
    }

    method path-generic-args-without-colons-item:sym<c>($/) {
        make Components.new(
            ident         => $<ident>.made,
            maybe-ty-sums => $<maybe-ty-sums>.made,
            ret-ty        => $<ret-ty>.made,
        )
    }
}

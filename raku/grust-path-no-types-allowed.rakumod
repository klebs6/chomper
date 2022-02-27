use grust-model;


our role PathNoTypesAllowed::Rules {

    proto rule path-no-types-allowed-base { * }

    rule path-no-types-allowed-base:sym<a> { <ident> }
    rule path-no-types-allowed-base:sym<b> { <MOD-SEP>? <SELF> }
    rule path-no-types-allowed-base:sym<c> { <MOD-SEP>? <SUPER> }

    rule path-no-types-allowed {  
        <path-no-types-allowed-base> [<MOD-SEP> <ident>]*
    }
}

our role PathNoTypesAllowed::Actions {

    method path-no-types-allowed($/) {
        make ViewPath.new(
            base =>  $<path-no-types-allowed-base>.made,
            tail =>  $<ident>>>.made,
        )
    }

    method path-no-types-allowed:sym-base<a>($/) { make $<ident>.made }
    method path-no-types-allowed:sym<b>($/)      { make $<SELF>.made }
    method path-no-types-allowed:sym<c>($/)      { make $<SUPER>.made }
}

our role PathGenericArgsWithoutColons::Rules {

    rule path-generic-args-without-colons {  
        {self.set-prec(IDENT)}
        <path-generic-args-without-colons-item>+ %% <MOD-SEP>
    }

    proto rule path-generic-args-without-colons-item { * }

    rule path-generic-args-without-colons-item<a> { <ident> }
    rule path-generic-args-without-colons-item<b> { <ident> <generic-args> }
    rule path-generic-args-without-colons-item<c> { <ident> '(' <maybe-ty-sums> ')' <ret-ty> }
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

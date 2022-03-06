use grust-model;

our role TraitRef::Rules {

    rule trait-ref {
        <tok-mod-sep>? 
        <path-generic-args-without-colons>
    }
}

our role TraitRef::Actions {

    method trait-ref($/) {
        make TraitRef.new(
            value => $<path-generic-args-without-colons>.made,
            text  => ~$/,
        )
    }
}

use grust-model;

our role TraitRef::Rules {

    rule trait-ref {
        #{self.set-prec(IDENT)} 
        <MOD-SEP>? 
        <path-generic-args-without-colons>
    }
}

our role TraitRef::Actions {

    method trait-ref($/) {
        make $<path-generic-args-without-colons>.made
    }
}

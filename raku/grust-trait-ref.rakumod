our class TraitRef::Rules {

    proto rule trait-ref { * }

    rule trait-ref:sym<a> {
        {self.set-prec(IDENT)} <path-generic_args_without_colons>
    }

    rule trait-ref:sym<b> {
        {self.set-prec(IDENT)} <MOD-SEP> <path-generic_args_without_colons>
    }
}

our class TraitRef::Actions {

    method trait-ref:sym<a>($/) {

    }

    method trait-ref:sym<b>($/) {
        make $<path_generic_args_without_colons>.made
    }
}

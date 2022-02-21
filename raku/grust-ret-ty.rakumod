our class Ret-ty {
    has $.ty;
}

our class RetTy::Rules {

    proto rule ret-ty { * }

    rule ret-ty:sym<a> {
        <RARROW> '!'
    }

    rule ret-ty:sym<b> {
        <RARROW> <ty>
    }

    rule ret-ty:sym<c> {
        #%prec IDENT 
    }
}

our class RetTy::Actions {

    method ret-ty:sym<a>($/) {
        MkNone<140295749868448>
    }

    method ret-ty:sym<b>($/) {
        make ret-ty.new(
            ty =>  $<ty>.made,
        )
    }

    method ret-ty:sym<c>($/) {
        MkNone<140295749870336>
    }
}

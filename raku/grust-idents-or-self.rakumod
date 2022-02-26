our class IdentsOrSelf {
    has $.idents-or-self;
    has $.ident-or-self;
    has $.ident;
}

our class IdentsOrSelf::Rules {

    rule idents-or-self {
        <ident-or-self> 
        <idents-or-self-tail>* 
    }

    proto rule idents-or-self-tail  { * }
    rule idents-or-self-tail:sym<a> { <AS> <ident> }
    rule idents-or-self-tail:sym<b> { ',' <ident-or-self> }

    proto rule ident-or-self        { * }
    rule ident-or-self:sym<ident>   { <ident> }
    rule ident-or-self:sym<self>    { <SELF>  }
}

our class IdentsOrSelf::Actions {

    method idents-or-self($/) {
        make IdentsOrSelf.new(
            ident-or-self => $<ident-or-self>.made,
            tail          => $<idents-or-self-tail>>>.made,
        )
    }

    method idents-or-self-tail:sym<a>($/) {
        make As.new(
            ident => $<ident>.made
        )
    }

    method idents-or-self-tail:sym<b>($/) {
        make $<ident-or-self>.made
    }

    method ident-or-self:sym<ident>($/) { make $<ident>.made }
    method ident-or-self:sym<self>($/)  { make ~$/ }
}

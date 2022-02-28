use grust-model;


our role RetTy::Rules {

    proto rule ret-ty { * }
    rule ret-ty:sym<panic> { <RARROW> '!' }
    rule ret-ty:sym<ty>    { <RARROW> <ty> }
}

our role RetTy::Actions {

    method ret-ty:sym<a>($/) {
        make RetTy.new(
            ty =>  $<panic>.made,
        )
    }

    method ret-ty:sym<b>($/) {
        make RetTy.new(
            ty =>  $<ty>.made,
        )
    }
}


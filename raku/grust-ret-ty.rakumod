use grust-model;

our role RetTy::Rules {

    rule ret-ty { <some-ret-ty>? }

    proto rule some-ret-ty { * }
    rule some-ret-ty:sym<panic> { <tok-rarrow> '!' }
    rule some-ret-ty:sym<ty>    { <tok-rarrow> <ty> }
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

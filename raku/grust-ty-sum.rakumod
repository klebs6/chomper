use grust-model;

our role TySums::Rules {

    rule maybe-ty-sums { [<ty-sums> ','?]? }
    rule ty-sums       { <ty-sum>+ %% "," }
    rule ty-sum        { <ty-sum-elt>+ %% "+" }

    #--------------------
    proto rule ty-sum-elt  { * }
    rule ty-sum-elt:sym<a> { <ty> }
    rule ty-sum-elt:sym<b> { <lifetime> }

    rule ty-prim-sum       { <ty-prim-sum-elt>+ %% "+" }

    #--------------------
    proto rule ty-prim-sum-elt { * }

    rule ty-prim-sum-elt:sym<a> { <ty-prim> }
    rule ty-prim-sum-elt:sym<b> { <lifetime> }
}

our role TySums::Actions {

    method maybe-ty-sums($/) {
        make $<ty-sums>.made
    }

    method ty-sums($/) {
        make $<ty-sum>>>.made
    }

    method ty-sum:sym<a>($/) {
        make TySum.new(
            ty-sum-elt =>  $<ty-sum-elt>>>.made,
        )
    }

    #-----------------
    method ty-sum-elt:sym<a>($/) {
        make $<ty>.made
    }

    method ty-sum-elt:sym<b>($/) {
        make $<lifetime>.made
    }

    #-----------------
    method ty-prim-sum($/) {
        make $<ty-prim-sum-elt>>>.made
    }

    method ty-prim-sum-elt:sym<a>($/) {
        make $<ty-prim>.made
    }

    method ty-prim-sum-elt:sym<b>($/) {
        make $<lifetime>.made
    }
}

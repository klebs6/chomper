use grust-model;

our role TySums::Rules {

    rule maybe-ty-sums { [<ty-sums> ','?]? }
    rule ty-sums       { <ty-sum>+ %% "," }
    rule ty-sum        { <ty-sum-elt>+ %% "+" }

    #--------------------
    proto rule ty-sum-elt  { * }

    rule ty-sum-elt:sym<type> { 
        <ty> 

        #can add to support trait_alias
        #but it breaks some other stuff..
        #
        #<maybe-ty-default>? 
    }

    rule ty-sum-elt:sym<lifetime>      { <lifetime> }
    rule ty-sum-elt:sym<const-generic> { <lit-int> }

    rule ty-prim-sum       { <ty-prim-sum-elt>+ %% "+" }

    #--------------------
    proto rule ty-prim-sum-elt { * }

    rule ty-prim-sum-elt:sym<a> { 
        <ty-prim> 

    }
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
    method ty-sum-elt:sym<type>($/) {
        make $<ty>.made
    }

    method ty-sum-elt:sym<lifetime>($/) {
        make $<lifetime>.made
    }

    #this isn't in the official grammar, but we
    #use it to help parse const-generics
    method ty-sum-elt:sym<const-generic>($/) {
        make $<lit-int>.made
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


use grust-model;

our role ForInType::Rules {

    rule for-in-type {
        <for_> '<' <maybe-lifetimes> '>' <for-in-type-suffix>
    }

    proto rule for-in-type-suffix { * }

    rule for-in-type-suffix:sym<ty-bare-fn> { <ty-bare-fn> }
    rule for-in-type-suffix:sym<trait-ref>  { <trait-ref> }
    rule for-in-type-suffix:sym<ty-closure> { <ty-closure> }
}

our role ForInType::Actions {

    method for-in-type($/) {
        make ForInType.new(
            maybe-lifetimes    =>  $<maybe-lifetimes>.made,
            for-in-type-suffix =>  $<for-in-type-suffix>.made,
        )
    }

    method for-in-type-suffix:sym<ty-bare-fn>($/) { make $<ty-bare-fn>.made }
    method for-in-type-suffix:sym<trait-ref>($/)  { make $<trait-ref>.made }
    method for-in-type-suffix:sym<ty-closure>($/) { make $<ty-closure>.made }
}

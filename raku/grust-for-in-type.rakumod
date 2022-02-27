use grust-model;

our role ForInType::Rules {

    rule for-in_type {
        <FOR> '<' <maybe-lifetimes> '>' <for-in_type_suffix>
    }

    proto rule for-in_type_suffix { * }

    rule for-in_type_suffix:sym<ty-bare-fn> { <ty-bare_fn> }
    rule for-in_type_suffix:sym<trait-ref>  { <trait-ref> }
    rule for-in_type_suffix:sym<ty-closure> { <ty-closure> }
}

our role ForInType::Actions {

    method for-in_type($/) {
        make ForInType.new(
            maybe-lifetimes    =>  $<maybe-lifetimes>.made,
            for-in_type_suffix =>  $<for-in_type_suffix>.made,
        )
    }

    method for-in_type_suffix:sym<ty-bare-fn>($/) { make $<ty-bare_fn>.made }
    method for-in_type_suffix:sym<trait-ref>($/)  { make $<trait-ref>.made }
    method for-in_type_suffix:sym<ty-closure>($/) { make $<ty-closure>.made }
}

our class ForInType {
    has $.for-in-type-suffix;
    has $.maybe-lifetimes;

    has $.text;

    submethod TWEAK {
        say self.gist;
    }

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our role ForInType::Rules {

    rule for-in-type {
        <kw-for> '<' <maybe-lifetimes> '>' <for-in-type-suffix>
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
            text                => ~$/,
        )
    }

    method for-in-type-suffix:sym<ty-bare-fn>($/) { make $<ty-bare-fn>.made }
    method for-in-type-suffix:sym<trait-ref>($/)  { make $<trait-ref>.made }
    method for-in-type-suffix:sym<ty-closure>($/) { make $<ty-closure>.made }
}

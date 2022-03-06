our class AttrsAndVis {
    has $.maybe-outer-attrs;
    has $.visibility;

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

our role AttrsAndVis::Rules {

    rule attrs-and-vis {
        <maybe-outer-attrs> <visibility>
    }
}

our role AttrsAndVis::Actions {

    method attrs-and-vis($/) {
        make AttrsAndVis.new(
            maybe-outer-attrs =>  $<maybe-outer-attrs>.made,
            visibility        =>  $<visibility>.made,
            text      => ~$/,
        )
    }
}

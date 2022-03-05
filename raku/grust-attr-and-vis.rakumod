use grust-model;

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

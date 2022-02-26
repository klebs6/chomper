our class AttrsAndVis {
    has $.maybe_outer_attrs;
    has $.visibility;
}

our role AttrsAndVis::Rules {

    rule attrs-and_vis {
        <maybe-outer_attrs> <visibility>
    }
}

our role AttrsAndVis::Actions {

    method attrs-and_vis($/) {
        make AttrsAndVis.new(
            maybe-outer_attrs =>  $<maybe-outer_attrs>.made,
            visibility        =>  $<visibility>.made,
        )
    }
}
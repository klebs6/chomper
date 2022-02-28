use grust-model;

our role Default::Rules {

    rule maybe-default {
        <kw-default>?
    }
}

our role Default::Actions {

    method default($/) {
        make Default.new
    }

    method maybe-default($/) {
        make $<kw-default>.made
    }
}

use grust-model;

our role Default::Rules {

    rule maybe-default {
        <default_>?
    }
}

our role Default::Actions {

    method default($/) {
        make Default.new
    }

    method maybe-default($/) {
        make $<default>.made
    }
}

use grust-model;

our role Default::Rules {

    rule maybe-default {
        <DEFAULT>?
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


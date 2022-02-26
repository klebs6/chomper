our class Default::Rules {

    rule maybe-default {
        <DEFAULT>?
    }
}

our class Default::Actions {

    method default($/) {
        make Default.new
    }

    method maybe-default($/) {
        make $<default>.made
    }
}

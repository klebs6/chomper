use grust-model;

our role Default::Rules {

    rule maybe-default {
        <kw-default>?
    }
}

our role Default::Actions {

    method maybe-default($/) {
        if $/<kw-default>:exists {
            make Default.new
        }
    }
}

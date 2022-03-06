our class Default { 

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

our role Default::Rules {

    rule maybe-default {
        <kw-default>?
    }
}

our role Default::Actions {

    method maybe-default($/) {
        if $/<kw-default>:exists {
            make Default.new(
                text => ~$/,
            )
        }
    }
}

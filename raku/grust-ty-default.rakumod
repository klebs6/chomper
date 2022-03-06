our class TyDefault {
    has $.ty-sum;

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

our role TyDefault::Rules {

    rule maybe-ty-default {
        <ty-default>?
    }

    rule ty-default {
        '=' <ty-sum>
    }
}

our role TyDefault::Actions {

    method maybe-ty-default($/) {
        make TyDefault.new(
            ty-sum => $<ty-sum>.made,
            text   => ~$/,
        )
    }
}

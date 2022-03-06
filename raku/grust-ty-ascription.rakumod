use Data::Dump::Tree;

our class TyAscription {
    has $.value;

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

our role TyAscription::Rules {

    rule ty-ascription {
        ':' <ty-sum>
    }

    rule maybe-ty-ascription {
        <ty-ascription>?
    }
}

our role TyAscription::Actions {

    method ty-ascription($/) {
        make TyAscription.new(
            value => $<ty-sum>.made,
            text  => ~$/,
        )
    }

    method maybe-ty-ascription($/) {
        make $<ty-ascription>.made
    }
}

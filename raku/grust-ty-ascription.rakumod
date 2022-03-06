use Data::Dump::Tree;

our class TyAscription {
    has $.ty-sum;

    has $.text;

    submethod TWEAK {
        self.gist;
    }

    method gist {
        ": {$.ty-sum.gist}"
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
            ty-sum => $<ty-sum>.made,
            text  => ~$/,
        )
    }

    method maybe-ty-ascription($/) {
        make $<ty-ascription>.made
    }
}

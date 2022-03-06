our class InferrableParam {
    has $.pat;
    has $.maybe-ty-ascription;

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

our class InferrableParams {
    has $.inferrable-param;

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

our role InferrableParams::Rules {

    rule inferrable-params {
        <inferrable-param>+ %% ","
    }

    rule inferrable-param {
        <pat>
        <maybe-ty-ascription>
    }
}

our role InferrableParams::Actions {

    method inferrable-params($/) {
        make $<inferrable-param>>>.made
    }

    method inferrable-param($/) {
        make InferrableParam.new(
            pat                 =>  $<pat>.made,
            maybe-ty-ascription =>  $<maybe-ty-ascription>.made,
            text                => ~$/,
        )
    }
}

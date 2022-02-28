use grust-model;


our role InferrableParams::Rules {

    rule inferrable-params {
        <inferrable-param>+ %% ","
    }

    rule inferrable-param {
        <pat> <maybe-ty-ascription>
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
        )
    }
}


our class InferrableParam {
    has $.pat;
    has $.maybe_ty_ascription;
}

our class InferrableParams {
    has $.inferrable_param;
}

our class InferrableParams::Rules {

    proto rule inferrable-params { * }

    rule inferrable-params:sym<a> {
        <inferrable-param>
    }

    rule inferrable-params:sym<b> {
        <inferrable-params> ',' <inferrable-param>
    }

    rule inferrable-param {
        <pat> <maybe-ty_ascription>
    }
}

our class InferrableParams::Actions {

    method inferrable-params:sym<a>($/) {
        make InferrableParams.new(
            inferrable-param =>  $<inferrable-param>.made,
        )
    }

    method inferrable-params:sym<b>($/) {
        ExtNode<140499837100840>
    }

    method inferrable-param($/) {
        make InferrableParam.new(
            pat                 =>  $<pat>.made,
            maybe-ty_ascription =>  $<maybe-ty_ascription>.made,
        )
    }
}

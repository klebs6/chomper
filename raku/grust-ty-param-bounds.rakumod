our class PolyBound {
    has $.maybe_lifetimes;
    has $.bound;
}

our class TyParamBounds::Rules {

    proto rule maybe-ty_param_bounds { * }

    rule maybe-ty_param_bounds:sym<a> {
        ':' <ty-param_bounds>
    }

    rule maybe-ty_param_bounds:sym<b> {

    }

    proto rule ty-param_bounds { * }

    rule ty-param_bounds:sym<a> {
        <boundseq>
    }

    rule ty-param_bounds:sym<b> {

    }

    proto rule boundseq { * }

    rule boundseq:sym<a> {
        <polybound>
    }

    rule boundseq:sym<b> {
        <boundseq> '+' <polybound>
    }

    proto rule polybound { * }

    rule polybound:sym<a> {
        <FOR> '<' <maybe-lifetimes> '>' <bound>
    }

    rule polybound:sym<b> {
        <bound>
    }

    rule polybound:sym<c> {
        '?' <FOR> '<' <maybe-lifetimes> '>' <bound>
    }

    rule polybound:sym<d> {
        '?' <bound>
    }
}

our class TyParamBounds::Actions {

    method maybe-ty_param_bounds:sym<a>($/) {
        make $<ty_param_bounds>.made
    }

    method maybe-ty_param_bounds:sym<b>($/) {
        MkNone<140367527828480>
    }

    method ty-param_bounds:sym<a>($/) {
        make $<boundseq>.made
    }

    method ty-param_bounds:sym<b>($/) {
        MkNone<140367527828512>
    }

    method boundseq:sym<a>($/) {
        make $<polybound>.made
    }

    method boundseq:sym<b>($/) {
        ExtNode<140367770100832>
    }

    method polybound:sym<a>($/) {
        make PolyBound.new(
            maybe-lifetimes =>  $<maybe-lifetimes>.made,
            bound           =>  $<bound>.made,
        )
    }

    method polybound:sym<b>($/) {
        make $<bound>.made
    }

    method polybound:sym<c>($/) {
        make PolyBound.new(
            maybe-lifetimes =>  $<maybe-lifetimes>.made,
            bound           =>  $<bound>.made,
        )
    }

    method polybound:sym<d>($/) {
        make $<bound>.made
    }
}


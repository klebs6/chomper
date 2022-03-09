use Data::Dump::Tree;

our class PolyBound {
    has $.maybe-lifetimes;
    has $.bound;

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

our role TyParamBounds::Rules {

    rule maybe-ty-param-bounds { [':' <ty-param-bounds>]? }
    rule ty-param-bounds       { <boundseq>? }

    #-----------------
    rule boundseq { <polybound>+ %% "+" }

    #-----------------
    proto rule polybound  { * }
    rule polybound:sym<a> { <kw-for> '<' <maybe-lifetimes> '>' <bound> }
    rule polybound:sym<b> { <bound> }
    rule polybound:sym<c> { '?' <kw-for> '<' <maybe-lifetimes> '>' <bound> }
    rule polybound:sym<d> { '?' <bound> }
}

our role TyParamBounds::Actions {

    method maybe-ty-param-bounds($/) {
        make $<ty-param-bounds>.made
    }

    method ty-param-bounds($/) {
        make $<boundseq>.made
    }

    method boundseq($/) {
        make $<polybound>>>.made
    }

    method polybound:sym<a>($/) {
        make PolyBound.new(
            maybe-lifetimes =>  $<maybe-lifetimes>.made,
            bound           =>  $<bound>.made,
            text            => ~$/,
        )
    }

    method polybound:sym<b>($/) {
        make $<bound>.made
    }

    method polybound:sym<c>($/) {
        make PolyBound.new(
            maybe-lifetimes =>  $<maybe-lifetimes>.made,
            bound           =>  $<bound>.made,
            text            => ~$/,
        )
    }

    method polybound:sym<d>($/) {
        make $<bound>.made
    }
}

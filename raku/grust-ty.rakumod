our class TyQualifiedPath {
    has $.ident;
    has $.maybe_as_trait_ref;
    has $.trait_ref;
    has $.ty_sum;
}

our class TyTup {
    has $.ty_sums;
}

our class Ty::Rules {

    proto rule ty { * }

    rule ty:sym<a> {
        <ty-prim>
    }

    rule ty:sym<b> {
        <ty-closure>
    }

    rule ty:sym<c> {
        '<' <ty-sum> <maybe-as_trait_ref> '>' <MOD-SEP> <ident>
    }

    rule ty:sym<d> {
        <SHL> <ty-sum> <maybe-as_trait_ref> '>' <MOD-SEP> <ident> <maybe-as_trait_ref> '>' <MOD-SEP> <ident>
    }

    rule ty:sym<e> {
        '(' <ty-sums> ')'
    }

    rule ty:sym<f> {
        '(' <ty-sums> ',' ')'
    }

    rule ty:sym<g> {
        '(' ')'
    }
}

our class Ty::Actions {

    method ty:sym<a>($/) {
        make $<ty-prim>.made
    }

    method ty:sym<b>($/) {
        make $<ty-closure>.made
    }

    method ty:sym<c>($/) {
        make TyQualifiedPath.new(
            ty-sum             =>  $<ty-sum>.made,
            maybe-as_trait_ref =>  $<maybe-as_trait_ref>.made,
            ident              =>  $<ident>.made,
        )
    }

    method ty:sym<d>($/) {
        make TyQualifiedPath.new(
            maybe-as_trait_ref =>  $<maybe-as_trait_ref>.made,
            ident              =>  $<ident>.made,
        )
    }

    method ty:sym<e>($/) {
        make TyTup.new(
            ty-sums =>  $<ty-sums>.made,
        )
    }

    method ty:sym<f>($/) {
        make TyTup.new(
            ty-sums =>  $<ty-sums>.made,
        )
    }

    method ty:sym<g>($/) {
        make TyNil.new
    }
}


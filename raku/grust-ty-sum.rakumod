our class TySum {
    has $.ty_sum_elt;
    has $.ty_prim_sum_elt;
}

our class TySums {
    has $.ty_sum;
}

our class TySums::G {

    proto rule maybe-ty_sums { * }

    rule maybe-ty_sums:sym<a> {
        <ty-sums>
    }

    rule maybe-ty_sums:sym<b> {
        <ty-sums> ','
    }

    rule maybe-ty_sums:sym<c> {

    }

    proto rule ty-sums { * }

    rule ty-sums:sym<a> {
        <ty-sum>
    }

    rule ty-sums:sym<b> {
        <ty-sums> ',' <ty-sum>
    }

    proto rule ty-sum { * }

    rule ty-sum:sym<a> {
        <ty-sum_elt>
    }

    rule ty-sum:sym<b> {
        <ty-sum> '+' <ty-sum_elt>
    }

    proto rule ty-sum_elt { * }

    rule ty-sum_elt:sym<a> {
        <ty>
    }

    rule ty-sum_elt:sym<b> {
        <lifetime>
    }

    proto rule ty-prim_sum { * }

    rule ty-prim_sum:sym<a> {
        <ty-prim_sum_elt>
    }

    rule ty-prim_sum:sym<b> {
        <ty-prim_sum> '+' <ty-prim_sum_elt>
    }

    proto rule ty-prim_sum_elt { * }

    rule ty-prim_sum_elt:sym<a> {
        <ty-prim>
    }

    rule ty-prim_sum_elt:sym<b> {
        <lifetime>
    }
}

our class TySums::A {

    method maybe-ty_sums:sym<a>($/) {
        make $<ty-sums>.made
    }

    method maybe-ty_sums:sym<b>($/) {

    }

    method maybe-ty_sums:sym<c>($/) {
        MkNone<140616559392320>
    }

    method ty-sums:sym<a>($/) {
        make TySums.new(
            ty-sum =>  $<ty-sum>.made,
        )
    }

    method ty-sums:sym<b>($/) {
        ExtNode<140615535303640>
    }

    method ty-sum:sym<a>($/) {
        make TySum.new(
            ty-sum_elt =>  $<ty-sum_elt>.made,
        )
    }

    method ty-sum:sym<b>($/) {
        ExtNode<140615535303680>
    }

    method ty-sum_elt:sym<a>($/) {
        make $<ty>.made
    }

    method ty-sum_elt:sym<b>($/) {
        make $<lifetime>.made
    }

    method ty-prim_sum:sym<a>($/) {
        make TySum.new(
            ty-prim_sum_elt =>  $<ty-prim_sum_elt>.made,
        )
    }

    method ty-prim_sum:sym<b>($/) {
        ExtNode<140615535303720>
    }

    method ty-prim_sum_elt:sym<a>($/) {
        make $<ty-prim>.made
    }

    method ty-prim_sum_elt:sym<b>($/) {
        make $<lifetime>.made
    }
}

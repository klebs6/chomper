use grust-model;

our role ItemImpl::Rules {

    #---------------------------
    proto rule item-impl { * }

    rule item-impl:sym<a> {
        <maybe-default-maybe-unsafe> 
        <kw-impl> 
        <generic-params> 
        <ty-prim-sum> 
        <maybe-where-clause> 
        '{' 
        <maybe-inner-attrs> 
        <maybe-impl-items> 
        '}'
    }

    rule item-impl:sym<b> {
        <maybe-default-maybe-unsafe> 
        <kw-impl> 
        <generic-params> 
        '(' <ty> ')' 
        <maybe-where-clause> 
        '{' <maybe-inner-attrs> <maybe-impl-items> '}'
    }

    rule item-impl:sym<c> {
        <maybe-default-maybe-unsafe> 
        <kw-impl> 
        <generic-params> 
        <trait-ref> 
        <kw-for> 
        <ty-sum> 
        <maybe-where-clause> 
        '{' <maybe-inner-attrs> <maybe-impl-items> '}'
    }

    rule item-impl:sym<d> {
        <maybe-default-maybe-unsafe> 
        <kw-impl> <generic-params> '!' 
        <trait-ref> 
        <kw-for> 
        <ty-sum> 
        <maybe-where-clause> 
        '{' <maybe-inner-attrs> <maybe-impl-items> '}'
    }

    rule item-impl:sym<e> {
        <maybe-default-maybe-unsafe> 
        <kw-impl> 
        <generic-params> 
        <trait-ref> 
        <kw-for> 
        <tok-dotdot> 
        '{' '}'
    }

    rule item-impl:sym<f> {
        <maybe-default-maybe-unsafe> 
        <kw-impl> 
        <generic-params> 
        '!' 
        <trait-ref> 
        <kw-for> 
        <tok-dotdot> 
        '{' '}'
    }
}

our role ItemImpl::Actions {

    method item-impl:sym<a>($/) {
        make ItemImpl.new(
            maybe-default-maybe-unsafe =>  $<maybe-default-maybe-unsafe>.made,
            generic-params             =>  $<generic-params>.made,
            ty-prim-sum                =>  $<ty-prim-sum>.made,
            maybe-where-clause         =>  $<maybe-where-clause>.made,
            maybe-inner-attrs          =>  $<maybe-inner-attrs>.made,
            maybe-impl-items           =>  $<maybe-impl-items>.made,
        )
    }

    method item-impl:sym<b>($/) {
        make ItemImpl.new(
            maybe-default-maybe-unsafe =>  $<maybe-default-maybe-unsafe>.made,
            generic-params             =>  $<generic-params>.made,
            ty                         =>  $<ty>.made,
            maybe-where-clause         =>  $<maybe-where-clause>.made,
            maybe-inner-attrs          =>  $<maybe-inner-attrs>.made,
            maybe-impl-items           =>  $<maybe-impl-items>.made,
        )
    }

    method item-impl:sym<c>($/) {
        make ItemImpl.new(
            generic-params     =>  $<generic-params>.made,
            trait-ref          =>  $<trait-ref>.made,
            ty-sum             =>  $<ty-sum>.made,
            maybe-where-clause =>  $<maybe-where-clause>.made,
            maybe-inner-attrs  =>  $<maybe-inner-attrs>.made,
            maybe-impl-items   =>  $<maybe-impl-items>.made,
        )
    }

    method item-impl:sym<d>($/) {
        make ItemImplNeg.new(
            maybe-default-maybe-unsafe =>  $<maybe-default-maybe-unsafe>.made,
            generic-params             =>  $<generic-params>.made,
            trait-ref                  =>  $<trait-ref>.made,
            ty-sum                     =>  $<ty-sum>.made,
            maybe-where-clause         =>  $<maybe-where-clause>.made,
            maybe-inner-attrs          =>  $<maybe-inner-attrs>.made,
            maybe-impl-items           =>  $<maybe-impl-items>.made,
        )
    }

    method item-impl:sym<e>($/) {
        make ItemImplDefault.new(
            maybe-default-maybe-unsafe =>  $<maybe-default-maybe-unsafe>.made,
            generic-params             =>  $<generic-params>.made,
            trait-ref                  =>  $<trait-ref>.made,
        )
    }

    method item-impl:sym<f>($/) {
        make ItemImplDefaultNeg.new(
            maybe-default-maybe-unsafe =>  $<maybe-default-maybe-unsafe>.made,
            generic-params             =>  $<generic-params>.made,
            trait-ref                  =>  $<trait-ref>.made,
        )
    }
}

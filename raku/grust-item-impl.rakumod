use grust-model;


our role ItemImpl::Rules {

    #---------------------------
    proto rule item-impl { * }

    rule item-impl:sym<a> {
        <maybe-default_maybe_unsafe> 
        <IMPL> 
        <generic-params> 
        <ty-prim_sum> 
        <maybe-where_clause> 
        '{' 
        <maybe-inner_attrs> 
        <maybe-impl_items> 
        '}'
    }

    rule item-impl:sym<b> {
        <maybe-default_maybe_unsafe> 
        <IMPL> 
        <generic-params> 
        '(' <ty> ')' 
        <maybe-where_clause> 
        '{' <maybe-inner_attrs> <maybe-impl_items> '}'
    }

    rule item-impl:sym<c> {
        <maybe-default_maybe_unsafe> 
        <IMPL> 
        <generic-params> 
        <trait-ref> 
        <FOR> 
        <ty-sum> 
        <maybe-where_clause> 
        '{' <maybe-inner_attrs> <maybe-impl_items> '}'
    }

    rule item-impl:sym<d> {
        <maybe-default_maybe_unsafe> 
        <IMPL> <generic-params> '!' 
        <trait-ref> 
        <FOR> 
        <ty-sum> 
        <maybe-where_clause> 
        '{' <maybe-inner_attrs> <maybe-impl_items> '}'
    }

    rule item-impl:sym<e> {
        <maybe-default_maybe_unsafe> 
        <IMPL> 
        <generic-params> 
        <trait-ref> 
        <FOR> 
        <DOTDOT> 
        '{' '}'
    }

    rule item-impl:sym<f> {
        <maybe-default_maybe_unsafe> 
        <IMPL> 
        <generic-params> 
        '!' 
        <trait-ref> 
        <FOR> 
        <DOTDOT> 
        '{' '}'
    }

    #---------------------------
    rule maybe-impl_items {
        <impl-items>?
    }

    #---------------------------
    rule impl-items {
        <impl-item>+
    }

    #---------------------------
    proto rule impl-item { * }

    rule impl-item:sym<a> {
        <impl-method>
    }

    rule impl-item:sym<b> {
        <attrs-and_vis> <item-macro>
    }

    rule impl-item:sym<c> {
        <impl-const>
    }

    rule impl-item:sym<d> {
        <impl-type>
    }
}

our role ItemImpl::Actions {

    method item-impl:sym<a>($/) {
        make ItemImpl.new(
            maybe-default_maybe_unsafe =>  $<maybe-default_maybe_unsafe>.made,
            generic-params             =>  $<generic-params>.made,
            ty-prim_sum                =>  $<ty-prim_sum>.made,
            maybe-where_clause         =>  $<maybe-where_clause>.made,
            maybe-inner_attrs          =>  $<maybe-inner_attrs>.made,
            maybe-impl_items           =>  $<maybe-impl_items>.made,
        )
    }

    method item-impl:sym<b>($/) {
        make ItemImpl.new(
            maybe-default_maybe_unsafe =>  $<maybe-default_maybe_unsafe>.made,
            generic-params             =>  $<generic-params>.made,
            ty                         =>  $<ty>.made,
            maybe-where_clause         =>  $<maybe-where_clause>.made,
            maybe-inner_attrs          =>  $<maybe-inner_attrs>.made,
            maybe-impl_items           =>  $<maybe-impl_items>.made,
        )
    }

    method item-impl:sym<c>($/) {
        make ItemImpl.new(
            generic-params     =>  $<generic-params>.made,
            trait-ref          =>  $<trait-ref>.made,
            ty-sum             =>  $<ty-sum>.made,
            maybe-where_clause =>  $<maybe-where_clause>.made,
            maybe-inner_attrs  =>  $<maybe-inner_attrs>.made,
            maybe-impl_items   =>  $<maybe-impl_items>.made,
        )
    }

    method item-impl:sym<d>($/) {
        make ItemImplNeg.new(
            maybe-default_maybe_unsafe =>  $<maybe-default_maybe_unsafe>.made,
            generic-params             =>  $<generic-params>.made,
            trait-ref                  =>  $<trait-ref>.made,
            ty-sum                     =>  $<ty-sum>.made,
            maybe-where_clause         =>  $<maybe-where_clause>.made,
            maybe-inner_attrs          =>  $<maybe-inner_attrs>.made,
            maybe-impl_items           =>  $<maybe-impl_items>.made,
        )
    }

    method item-impl:sym<e>($/) {
        make ItemImplDefault.new(
            maybe-default_maybe_unsafe =>  $<maybe-default_maybe_unsafe>.made,
            generic-params             =>  $<generic-params>.made,
            trait-ref                  =>  $<trait-ref>.made,
        )
    }

    method item-impl:sym<f>($/) {
        make ItemImplDefaultNeg.new(
            maybe-default_maybe_unsafe =>  $<maybe-default_maybe_unsafe>.made,
            generic-params             =>  $<generic-params>.made,
            trait-ref                  =>  $<trait-ref>.made,
        )
    }

    method maybe-impl_items:sym<a>($/) {
        make $<impl-items>.made
    }

    #---------------------
    method impl-items($/) {
        make $<impl-item>>>.made
    }

    method impl-item:sym<a>($/) {
        make $<impl-method>.made
    }

    method impl-item:sym<b>($/) {
        make ImplMacroItem.new(
            attrs-and_vis =>  $<attrs-and_vis>.made,
            item-macro    =>  $<item-macro>.made,
        )
    }

    method impl-item:sym<c>($/) {
        make $<impl-const>.made
    }

    method impl-item:sym<d>($/) {
        make $<impl-type>.made
    }
}

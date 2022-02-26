
#------------------------------
# There are two forms of impl:
#
# impl (<...>)? TY { ... }
# impl (<...>)? TRAIT for TY { ... }
#
# Unfortunately since TY can begin with '<' itself
# -- as part of a TyQualifiedPath type -- there's
# an s/r conflict when we see '<' after IMPL:
#
# should we reduce one of the early rules of TY
# (such as maybe_once) or shall we continue
# shifting into the generic_params list for the
# impl?
#
# The production parser disambiguates a different
# case here by permitting / requiring the user to
# provide parens around types when they are
# ambiguous with traits. We do the same here,
# regrettably, by splitting ty into ty and
# ty_prim.
our class ImplItems {
    has $.impl_item;
}

our class ImplMacroItem {
    has $.item_macro;
    has $.attrs_and_vis;
}

our class ItemImpl {
    has $.trait_ref;
    has $.ty_prim_sum;
    has $.maybe_default_maybe_unsafe;
    has $.maybe_where_clause;
    has $.ty;
    has $.maybe_impl_items;
    has $.ty_sum;
    has $.generic_params;
    has $.maybe_inner_attrs;
}

our class ItemImplDefault {
    has $.maybe_default_maybe_unsafe;
    has $.generic_params;
    has $.trait_ref;
}

our class ItemImplDefaultNeg {
    has $.trait_ref;
    has $.maybe_default_maybe_unsafe;
    has $.generic_params;
}

our class ItemImplNeg {
    has $.maybe_default_maybe_unsafe;
    has $.maybe_inner_attrs;
    has $.trait_ref;
    has $.maybe_impl_items;
    has $.maybe_where_clause;
    has $.ty_sum;
    has $.generic_params;
}

our class ItemImpl::Rules {

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

our class ItemImpl::Actions {

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

our class ItemTrait {
    has $.maybe_where_clause;
    has $.maybe_unsafe;
    has $.generic_params;
    has $.for_sized;
    has $.maybe_ty_param_bounds;
    has $.maybe_trait_items;
    has $.ident;
}

our class TraitItems {
    has $.trait_item;
}

our class TraitMacroItem {
    has $.maybe_outer_attrs;
    has $.item_macro;
}

our class ItemTrait::Rules {

    rule item-trait {
        <maybe-unsafe> 
        <TRAIT> 
        <ident> 
        <generic-params> 
        <for-sized> 
        <maybe-ty_param_bounds> 
        <maybe-where_clause> 
        '{' <maybe-trait_items> '}'
    }

    proto rule maybe-trait_items { * }

    rule maybe-trait_items:sym<a> {
        <trait-items>
    }

    rule maybe-trait_items:sym<b> {

    }

    proto rule trait-items { * }

    rule trait-items:sym<a> {
        <trait-item>
    }

    rule trait-items:sym<b> {
        <trait-items> <trait-item>
    }

    proto rule trait-item { * }

    rule trait-item:sym<a> {
        <trait-const>
    }

    rule trait-item:sym<b> {
        <trait-type>
    }

    rule trait-item:sym<c> {
        <trait-method>
    }

    rule trait-item:sym<d> {
        <maybe-outer_attrs> <item-macro>
    }
}

our class ItemTrait::Actions {

    method item-trait($/) {
        make ItemTrait.new(
            maybe-unsafe          =>  $<maybe-unsafe>.made,
            ident                 =>  $<ident>.made,
            generic-params        =>  $<generic-params>.made,
            for-sized             =>  $<for-sized>.made,
            maybe-ty_param_bounds =>  $<maybe-ty_param_bounds>.made,
            maybe-where_clause    =>  $<maybe-where_clause>.made,
            maybe-trait_items     =>  $<maybe-trait_items>.made,
        )
    }

    method maybe-trait_items:sym<a>($/) {
        make $<trait-items>.made
    }

    method maybe-trait_items:sym<b>($/) {
        MkNone<140215433189312>
    }

    method trait-items:sym<a>($/) {
        make TraitItems.new(
            trait-item =>  $<trait-item>.made,
        )
    }

    method trait-items:sym<b>($/) {
        ExtNode<140215424168608>
    }

    method trait-item:sym<a>($/) {
        make $<trait-const>.made
    }

    method trait-item:sym<b>($/) {
        make $<trait-type>.made
    }

    method trait-item:sym<c>($/) {
        make $<trait-method>.made
    }

    method trait-item:sym<d>($/) {
        make TraitMacroItem.new(
            maybe-outer_attrs =>  $<maybe-outer_attrs>.made,
            item-macro        =>  $<item-macro>.made,
        )
    }
}


use grust-model;


our role ItemTrait::Rules {

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

    rule maybe-trait_items {
        <trait-items>?
    }

    rule trait-items {
        <trait-item>+
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

our role ItemTrait::Actions {

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

    method maybe-trait_items($/) {
        make $<trait-items>.made
    }

    method trait-items($/) {
        make $<trait-item>>>.made
    }

    #----------
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

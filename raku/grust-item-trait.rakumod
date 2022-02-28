use grust-model;

our role ItemTrait::Rules {

    rule item-trait {
        <maybe-unsafe> 
        <kw-trait> 
        <ident> 
        <generic-params> 
        <for-sized> 
        <maybe-ty-param-bounds> 
        <maybe-where-clause> 
        '{' <maybe-trait-items> '}'
    }

    rule maybe-trait-items {
        <trait-items>?
    }

    rule trait-items {
        <trait-item>+
    }

    #----------------------
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
        <maybe-outer-attrs>
        <item-macro>
    }
}

our role ItemTrait::Actions {

    method item-trait($/) {
        make ItemTrait.new(
            maybe-unsafe          =>  $<maybe-unsafe>.made,
            ident                 =>  $<ident>.made,
            generic-params        =>  $<generic-params>.made,
            for-sized             =>  $<for-sized>.made,
            maybe-ty-param-bounds =>  $<maybe-ty-param-bounds>.made,
            maybe-where-clause    =>  $<maybe-where-clause>.made,
            maybe-trait-items     =>  $<maybe-trait-items>.made,
        )
    }

    method maybe-trait-items($/) {
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
            maybe-outer-attrs =>  $<maybe-outer-attrs>.made,
            item-macro        =>  $<item-macro>.made,
        )
    }
}

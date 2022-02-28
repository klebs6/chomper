use grust-model;

our role BlockItem::Rules {

    proto rule block-item { * }
    rule block-item:sym<fn>          { <item-fn> }
    rule block-item:sym<unsafe-fn>   { <item-unsafe-fn> }
    rule block-item:sym<mod>         { <item-mod> }
    rule block-item:sym<foreign-mod> { <item-foreign-mod> }
    rule block-item:sym<struct>      { <item-struct> }
    rule block-item:sym<enum>        { <item-enum> }
    rule block-item:sym<union>       { <item-union> }
    rule block-item:sym<trait>       { <item-trait> }
    rule block-item:sym<impl>        { <item-impl> }
}

our role BlockItem::Actions {

    method block-item:sym<fn>($/)        { make $<item-fn>.made }
    method block-item:sym<unsafe-fn>($/) { make $<item-unsafe-fn>.made }
    method block-item:sym<mod>($/)       { make $<item-mod>.made }

    method block-item:sym<foreign-mod>($/) {
        make ItemForeignMod.new(
            item-foreign-mod =>  $<item-foreign-mod>.made,
        )
    }

    method block-item:sym<struct>($/) { make $<item-struct>.made }
    method block-item:sym<enum>($/)   { make $<item-enum>.made }
    method block-item:sym<union>($/)  { make $<item-union>.made }
    method block-item:sym<trait>($/)  { make $<item-trait>.made }
    method block-item:sym<impl>($/)   { make $<item-impl>.made }
}

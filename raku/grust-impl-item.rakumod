use grust-model;

our role ImplItem::Rules {

    rule maybe-impl-items {
        <impl-items>?
        <comment>?
    }

    rule impl-items {
        <impl-item>+
    }

    rule impl-item {  
        <comment>?
        <impl-item-base>
    }

    proto rule impl-item-base { * }

    rule impl-item-base:sym<a> {
        <impl-method>
    }

    rule impl-item-base:sym<b> {
        <attrs-and-vis> 
        <item-macro>
    }

    rule impl-item-base:sym<c> {
        <impl-const>
    }

    rule impl-item-base:sym<d> {
        <impl-type>
    }
}

our role ImplItem::Actions {

    method maybe-impl-items($/) {
        make ImplItems.new(
            impl-items => $<impl-items>.made,
            comment    => $<comment>.made,
            text       => ~$/,
        )
    }

    method impl-items($/) {
        make $<impl-item>>>.made
    }

    method impl-item($/) {
        make ImplItem.new(
            value   => $<impl-item-base>.made,
            comment => $<comment>.made,
            text    => ~$/,
        )
    }

    method impl-item-base:sym<a>($/) {
        make $<impl-method>.made
    }

    method impl-item-base:sym<b>($/) {
        make ImplMacroItem.new(
            attrs-and-vis =>  $<attrs-and-vis>.made,
            item-macro    =>  $<item-macro>.made,
            text          => ~$/,
        )
    }

    method impl-item-base:sym<c>($/) {
        make $<impl-const>.made
    }

    method impl-item-base:sym<d>($/) {
        make $<impl-type>.made
    }
}

#------------------------------
# items that can appear in "stmts"
our class StmtItem::G {

    proto rule stmt-item { * }

    rule stmt-item:sym<a> {
        <item-static>
    }

    rule stmt-item:sym<b> {
        <item-const>
    }

    rule stmt-item:sym<c> {
        <item-type>
    }

    rule stmt-item:sym<d> {
        <block-item>
    }

    rule stmt-item:sym<e> {
        <view-item>
    }
}

our class StmtItem::A {

    method stmt-item:sym<a>($/) {
        make $<item-static>.made
    }

    method stmt-item:sym<b>($/) {
        make $<item-const>.made
    }

    method stmt-item:sym<c>($/) {
        make $<item-type>.made
    }

    method stmt-item:sym<d>($/) {
        make $<block-item>.made
    }

    method stmt-item:sym<e>($/) {
        make $<view-item>.made
    }
}


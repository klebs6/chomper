use Data::Dump::Tree;

our class Item {
    has $.comment;
    has $.item;
    has $.attrs-and-vis;

    has $.text;

    submethod TWEAK {
        say self.gist;
    }

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

#-----------------------
our role ModItem::Rules {

    rule mod-item {
        <comment>?
        <attrs-and-vis> <item>
    }
}

our role ModItem::Actions {

    method mod-item($/) {
        make Item.new(
            comment       => $<comment>.made,
            attrs-and-vis => $<attrs-and-vis>.made,
            item          => $<item>.made,
            text          => ~$/,
        )
    }
}

#-----------------------
our role ModItems::Rules {

    rule maybe-mod-items {
        <mod-items>?
    }

    rule mod-items {
        <mod-item>+
    }
}

our role ModItems::Actions {

    method maybe-mod-items($/) {
        make $<mod-items>.made
    }

    method mod-items($/) {
        make $<mod-item>>>.made
    }
}

our class ViewItemUse {
    has $.view-path;

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

our role UseItem::Rules {

    rule use-item {
        <kw-use> <view-path> ';'
    }
}

our role UseItem::Actions {

    method use-item($/) {
        make ViewItemUse.new(
            view-path => $<view-path>.made,
            text      => ~$/,
        )
    }
}

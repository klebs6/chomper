
our class ViewItemUse {
    has $.view_path;
}

our class UseItem::G {

    rule use-item {
        <USE> <view-path> ';'
    }
}

our class UseItem::A {

    method use-item($/) {
        make ViewItemUse.new(
            view-path =>  $<view-path>.made,
        )
    }
}

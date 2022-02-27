our class ViewItemUse {
    has $.view_path;
}

our class UseItem::Rules {

    rule use-item {
        <USE> <view-path> ';'
    }
}

our class UseItem::Actions {

    method use-item($/) {
        make ViewItemUse.new(
            view-path =>  $<view-path>.made,
        )
    }
}

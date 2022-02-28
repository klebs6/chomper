use grust-model;

our role UseItem::Rules {

    rule use-item {
        <use_> <view-path> ';'
    }
}

our role UseItem::Actions {

    method use-item($/) {
        make ViewItemUse.new(
            view-path =>  $<view-path>.made,
        )
    }
}

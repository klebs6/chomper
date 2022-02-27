use grust-model;


our role UseItem::Rules {

    rule use-item {
        <USE> <view-path> ';'
    }
}

our role UseItem::Actions {

    method use-item($/) {
        make ViewItemUse.new(
            view-path =>  $<view-path>.made,
        )
    }
}

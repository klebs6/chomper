use grust-model;

our role ExternFnItem::Rules {

    rule extern-fn-item {
        <kw-extern> <maybe-abi> <item-fn>
    }
}

our role ExternFnItem::Actions {

    method extern-fn-item($/) {
        make ViewItemExternFn.new(
            maybe-abi =>  $<maybe-abi>.made,
            item-fn   =>  $<item-fn>.made,
        )
    }
}

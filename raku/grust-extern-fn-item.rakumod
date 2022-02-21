our class ViewItemExternFn {
    has $.item_fn;
    has $.maybe_abi;
}

our class ExternFnItem::Rules {

    rule extern-fn_item {
        <EXTERN> <maybe-abi> <item-fn>
    }
}

our class ExternFnItem::Actions {

    method extern-fn_item($/) {
        make ViewItemExternFn.new(
            maybe-abi =>  $<maybe-abi>.made,
            item-fn   =>  $<item-fn>.made,
        )
    }
}


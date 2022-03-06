our class ViewItemExternFn {
    has $.item-fn;
    has $.maybe-abi;

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

our role ExternFnItem::Rules {

    rule extern-fn-item {
        <kw-extern> 
        <maybe-abi> 
        <item-fn>
    }
}

our role ExternFnItem::Actions {

    method extern-fn-item($/) {
        make ViewItemExternFn.new(
            maybe-abi =>  $<maybe-abi>.made,
            item-fn   =>  $<item-fn>.made,
            text      => ~$/,
        )
    }
}

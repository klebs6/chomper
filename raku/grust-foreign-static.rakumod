our class StaticItem {
    has $.maybe-mut;
    has $.ident;
    has $.ty;

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

our role ForeignStatic::Rules {

    rule item-foreign-static {
        <maybe-mut> <ident> ':' <ty> ';'
    }
}

our role ForeignStatic::Actions {

    method item-foreign-static($/) {
        make StaticItem.new(
            maybe-mut =>  $<maybe-mut>.made,
            ident     =>  $<ident>.made,
            ty        =>  $<ty>.made,
            text      => ~$/,
        )
    }
}

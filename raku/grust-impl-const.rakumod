our class ImplConst {
    has $.maybe-default;
    has $.attrs-and-vis;
    has $.item-const;

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

our role ImplConst::Rules {

    rule impl-const {
        <attrs-and-vis> 
        <maybe-default> 
        <item-const>
    }
}

our role ImplConst::Actions {

    method impl-const($/) {
        make ImplConst.new(
            attrs-and-vis =>  $<attrs-and-vis>.made,
            maybe-default =>  $<maybe-default>.made,
            item-const    =>  $<item-const>.made,
            text          => ~$/,
        )
    }
}

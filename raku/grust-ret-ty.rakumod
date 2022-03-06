use Data::Dump::Tree;



our class RetTy {
    has $.ty;
    has $.panic;

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

our role RetTy::Rules {

    rule ret-ty { <some-ret-ty>? }

    proto rule some-ret-ty { * }
    rule some-ret-ty:sym<panic> { <tok-rarrow> '!' }
    rule some-ret-ty:sym<ty>    { <tok-rarrow> <ty> }
}

our role RetTy::Actions {

    method ret-ty($/) {
        make $<some-ret-ty>.made
    }

    method some-ret-ty:sym<panic>($/) {
        make RetTy.new(
            ty   => "panic",
            text => ~$/,
        )
    }

    method some-ret-ty:sym<ty>($/) {
        make RetTy.new(
            ty   => $<ty>.made,
            text => ~$/,
        )
    }
}

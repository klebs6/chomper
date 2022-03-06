our class PatStruct {
    has $.pat-fields;
    has $.pat-struct;
    has $.path-expr;

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

our role PatStruct::Rules {

    rule pat-struct { [[<pat-fields> ','?]? <tok-dotdot>?]? }
}

our role PatStruct::Actions {

    method pat-struct($/) {
        make PatStruct.new(
            pat-fields =>  $<pat-fields>.made,
            text       => ~$/,
        )
    }
}

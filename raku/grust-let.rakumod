our class DeclLocal {
    has $.pat;
    has $.maybe-init-expr;
    has $.maybe-ty-ascription;

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

our role Let::Rules {

    rule let {
        <kw-let> 
        <pat> 
        <maybe-ty-ascription> 
        <maybe-init-expr> ';'
    }
}

our role Let::Actions {

    method let($/) {
        make DeclLocal.new(
            pat                 =>  $<pat>.made,
            maybe-ty-ascription =>  $<maybe-ty-ascription>.made,
            maybe-init-expr     =>  $<maybe-init-expr>.made,
            text                => ~$/,
        )
    }
}

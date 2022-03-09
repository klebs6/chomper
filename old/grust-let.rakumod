use Data::Dump::Tree;

our class DeclLocal {
    has $.pat;
    has $.maybe-init-expr;
    has $.maybe-ty-ascription;

    has $.text;

    method gist {
        my $pat                 = $.pat.gist;
        my $maybe-ty-ascription = $.maybe-ty-ascription.gist;
        my $maybe-init-expr     = $.maybe-init-expr.gist;

        if $.maybe-ty-ascription {
            "let $pat$maybe-ty-ascription $maybe-init-expr"
        } else {
            "let $pat$maybe-init-expr"

        }
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

use Data::Dump::Tree;

our class ExprQualifiedPath {
    has $.ty-sum;
    has $.maybe-as-trait-ref0;

    has $.identA;
    has $.generic-argsA;
    has $.maybe-as-trait-ref1;

    has $.identB;
    has $.generic-argsB;

    has $.maybe-qpath-params;

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

our role ExprQualifiedPath::Rules {

    proto rule expr-qualified-path { * }

    rule expr-qualified-path:sym<a> {
        '<' 
        <ty-sum> 
        <maybe-as-trait-ref> 
        '>' 
        <tok-mod-sep> 
        <ident> 
        <maybe-qpath-params>
    }

    rule expr-qualified-path:sym<e> {
        <tok-shl> 
        <ty-sum> 
        <maybe-as-trait-ref> 
        '>' 
        <tok-mod-sep> 
        <ident> 
        <generic-args>?
        <maybe-as-trait-ref> 
        '>' 
        <tok-mod-sep> 
        <ident> 
        <generic-args>?
    }
}

our role ExprQualifiedPath::Actions {

    method expr-qualified-path:sym<a>($/) {
        make ExprQualifiedPath.new(
            ty-sum              =>  $<ty-sum>.made,
            maybe-as-trait-ref0 =>  $<maybe-as-trait-ref>.made,
            identA              =>  $<ident>.made,
            maybe-qpath-params  =>  $<maybe-qpath-params>.made,
            text                => ~$/,
        )
    }

    method expr-qualified-path:sym<e>($/) {
        make ExprQualifiedPath.new(
            ty-sum              =>  $<ty-sum>.made,
            maybe-as-trait-ref0 =>  $<maybe-as-trait-ref>>>.made[0],

            identA              =>  $<ident>>>.made[0],
            generic-argsA       =>  $<generic-args>>>.made[0],
            maybe-as-trait-ref1 =>  $<maybe-as-trait-ref>>>.made[1],

            identB              =>  $<ident>>>.made[1],
            generic-argsB       =>  $<generic-args>>>.made[1],
            text                => ~$/,
        )
    }
}

use Data::Dump::Tree;

use grust-generic-args;

our class DynTyPrim {
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

our class TyNil { 

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

our class TyTup {
    has $.ty-sums;

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

our role Ty::Rules {

    proto rule ty { * }

    #should this be here? is this how we 
    #want to handle "dyn"?
    rule ty:sym<dyn> { <kw-dyn> <ty-prim> }

    rule ty:sym<prim>    { <ty-prim> }
    rule ty:sym<closure> { <ty-closure> }

    rule ty:sym<c> { 
        '<' <ty-sum> <maybe-as-trait-ref> '>' 
        <tok-mod-sep> 
        <ident> 
    }

    rule ty:sym<d> { 
        <tok-shl> 
        <ty-sum> 
        <maybe-as-trait-ref> 
        '>' 
        <tok-mod-sep> 
        <ident> 
        <maybe-as-trait-ref> 
        '>' 
        <tok-mod-sep> 
        <ident> 
    }

    rule ty:sym<e> { '(' <ty-sums> ')' }
    rule ty:sym<f> { '(' <ty-sums> ',' ')' }
    rule ty:sym<g> { '(' ')' }
}

our role Ty::Actions {

    method ty:sym<dyn>($/) {
        make DynTyPrim.new(
            ty   => $<ty-prim>.made,
            text => ~$/,
        )
    }

    method ty:sym<prim>($/) {
        make $<ty-prim>.made
    }

    method ty:sym<closure>($/) {
        make $<ty-closure>.made
    }

    method ty:sym<c>($/) {
        make TyQualifiedPath.new(
            ty-sum             =>  $<ty-sum>.made,
            maybe-as-trait-ref =>  $<maybe-as-trait-ref>.made,
            ident              =>  $<ident>.made,
            text               => ~$/,
        )
    }

    method ty:sym<d>($/) {
        make TyQualifiedPath.new(
            maybe-as-trait-ref =>  $<maybe-as-trait-ref>.made,
            ident              =>  $<ident>.made,
            text               => ~$/,
        )
    }

    method ty:sym<e>($/) {
        make TyTup.new(
            ty-sums => $<ty-sums>.made,
            text    => ~$/,
        )
    }

    method ty:sym<f>($/) {
        make TyTup.new(
            ty-sums => $<ty-sums>.made,
            text    => ~$/,
        )
    }

    method ty:sym<g>($/) {
        make TyNil.new(
            text    => ~$/,
        )
    }
}

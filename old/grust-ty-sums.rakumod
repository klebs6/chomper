use Data::Dump::Tree;

our class TypeWithDefault {
    has $.ty;
    has $.default;

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

our class TySum {
    has @.ty-sum-elts;

    has $.text;

    method gist {
        @.ty-sum-elts>>.gist.join(" + ").trim
    }
}

our role TySums::Rules {

    rule maybe-ty-sums { [<ty-sums> ','?]? }
    rule ty-sums       { <ty-sum>+ %% "," }
    rule ty-sum        { <ty-sum-elt>+ %% "+" }

    #--------------------
    proto rule ty-sum-elt  { * }

    token ty-sum-elt:sym<type-with-default> { 
        <ty> 
        '=' 
        <ty-sum>
    }

    rule ty-sum-elt:sym<type>          { <ty> }
    rule ty-sum-elt:sym<lifetime>      { <lifetime> }
    rule ty-sum-elt:sym<const-generic> { <lit-int> }

    rule ty-prim-sum { <ty-prim-sum-elt>+ %% "+" }

    #--------------------
    proto rule ty-prim-sum-elt { * }

    rule ty-prim-sum-elt:sym<a> {
        <ty-prim> 
    }

    rule ty-prim-sum-elt:sym<b> {
        <lifetime>
    }
}

our role TySums::Actions {

    method maybe-ty-sums($/) {
        make $<ty-sums>.made
    }

    method ty-sums($/) {
        make $<ty-sum>>>.made
    }

    method ty-sum($/) {
        make TySum.new(
            ty-sum-elts => $<ty-sum-elt>>>.made,
            text        => ~$/,
        )
    }

    #-----------------
    method ty-sum-elt:sym<type-with-default>($/) {
        make TypeWithDefault.new(
            ty      => $<ty>.made,
            default => $<ty-sum>.made,
            text    => ~$/,
        )
    }

    method ty-sum-elt:sym<type>($/) {
        make $<ty>.made
    }

    method ty-sum-elt:sym<lifetime>($/) {
        make $<lifetime>.made
    }

    #this isn't in the official grammar, but we
    #use it to help parse const-generics
    method ty-sum-elt:sym<const-generic>($/) {
        make $<lit-int>.made
    }

    #-----------------
    method ty-prim-sum($/) {
        make $<ty-prim-sum-elt>>>.made
    }

    method ty-prim-sum-elt:sym<a>($/) {
        make $<ty-prim>.made
    }

    method ty-prim-sum-elt:sym<b>($/) {
        make $<lifetime>.made
    }
}

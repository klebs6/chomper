our class PatEnum {
    has $.path-expr;
    has $.pat-tup;

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

our class PatTup {
    has $.pat-tup;
    has $.pat-tup-elts;

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

our class PatUniq {
    has $.pat;

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

our class PatRange {
    has $.lit-or-pathA;
    has $.lit-or-pathB;

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

our class PatMac {
    has $.maybe-ident;
    has $.path-expr;
    has $.delimited-token-trees;

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

our class PatRegion {
    has Bool $.mut = False;
    has $.pat;

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

our class PatRegionRefRef {
    has $.pat;

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

our class PatUnit { 

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

our class PatQualifiedPath {
    has $.ty-sum;
    has $.maybe-as-trait-refA;
    has $.identA;
    has $.maybe-as-trait-refB;
    has $.identB;

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

our class PatWild { 

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

our class PatIdent {
    has $.pat;
    has $.ident;
    has $.binding-mode;

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

our role Pat::Rules {

    proto rule pat { * }

    rule pat:sym<a> { <tok-underscore> }
    rule pat:sym<b> { '&' <pat> }
    rule pat:sym<c> { '&' <kw-mut> <pat> }
    rule pat:sym<d> { <tok-andand> <pat> }
    rule pat:sym<e> { '(' ')' }
    rule pat:sym<f> { '(' <pat-tup> ')' }
    rule pat:sym<g> { '[' <pat-vec> ']' }
    rule pat:sym<j> { <path-expr> '{' <pat-struct> '}' }
    rule pat:sym<k> { <path-expr> '(' ')' }
    rule pat:sym<l> { <path-expr> '(' <pat-tup> ')' }
    rule pat:sym<m> { <path-expr> '!' <maybe-ident> <delimited-token-trees> }
    rule pat:sym<h> { <lit-or-path> }
    rule pat:sym<i> { <lit-or-path> <tok-dotdotdot> <lit-or-path> }
    rule pat:sym<n> { <binding-mode> <ident> }
    rule pat:sym<o> { <ident> '@' <pat> }
    rule pat:sym<p> { <binding-mode> <ident> '@' <pat> }
    rule pat:sym<q> { <kw-box> <pat> }

    rule pat:sym<r> { 
        '<' 
        <ty-sum> 
        <maybe-as-trait-ref> 
        '>' 
        <tok-mod-sep> 
        <ident> 
    }

    rule pat:sym<s> { 
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

    rule pats-or {
        <pat>+ %% "|"
    }
}

our role Pat::Actions {

    method pat:sym<a>($/) {
        make PatWild.new(
            text         => ~$/,
        )
    }

    method pat:sym<b>($/) {
        make PatRegion.new(
            pat  =>  $<pat>.made,
            text => ~$/,
        )
    }

    method pat:sym<c>($/) {
        make PatRegion.new(
            mut  => True,
            pat  => $<pat>.made,
            text => ~$/,
        )
    }

    method pat:sym<d>($/) {
        make PatRegionRefRef.new(
            pat  => $<pat>.made,
            text => ~$/,
        )
    }

    method pat:sym<e>($/) {
        make PatUnit.new(
            text => ~$/,
        )
    }

    method pat:sym<f>($/) {
        make PatTup.new(
            pat-tup => $<pat-tup>.made,
            text    => ~$/,
        )
    }

    method pat:sym<g>($/) {
        make PatVec.new(
            pat-vec => $<pat-vec>.made,
            text    => ~$/,
        )
    }

    method pat:sym<h>($/) {
        make $<lit-or-path>.made
    }

    method pat:sym<i>($/) {
        make PatRange.new(
            lit-or-pathA =>  $<lit-or-path>.made,
            lit-or-pathB =>  $<lit-or-path>.made,
            text         => ~$/,
        )
    }

    method pat:sym<j>($/) {
        make PatStruct.new(
            path-expr  => $<path-expr>.made,
            pat-struct => $<pat-struct>.made,
            text       => ~$/,
        )
    }

    method pat:sym<k>($/) {
        make PatEnum.new(
            path-expr => $<path-expr>.made,
            text      => ~$/,
        )
    }

    method pat:sym<l>($/) {
        make PatEnum.new(
            path-expr =>  $<path-expr>.made,
            pat-tup   =>  $<pat-tup>.made,
            text      => ~$/,
        )
    }

    method pat:sym<m>($/) {
        make PatMac.new(
            path-expr             => $<path-expr>.made,
            maybe-ident           => $<maybe-ident>.made,
            delimited-token-trees => $<delimited-token-trees>.made,
            text                  => ~$/,
        )
    }

    method pat:sym<n>($/) {
        make PatIdent.new(
            binding-mode => $<binding-mode>.made,
            ident        => $<ident>.made,
            text         => ~$/,
        )
    }

    method pat:sym<o>($/) {
        make PatIdent.new(
            ident => $<ident>.made,
            pat   => $<pat>.made,
            text  => ~$/,
        )
    }

    method pat:sym<p>($/) {
        make PatIdent.new(
            binding-mode =>  $<binding-mode>.made,
            ident        =>  $<ident>.made,
            pat          =>  $<pat>.made,
            text         => ~$/,
        )
    }

    method pat:sym<q>($/) {
        make PatUniq.new(
            pat  => $<pat>.made,
            text => ~$/,
        )
    }

    method pat:sym<r>($/) {
        make PatQualifiedPath.new(
            ty-sum             =>  $<ty-sum>.made,
            maybe-as-trait-ref =>  $<maybe-as-trait-ref>.made,
            ident              =>  $<ident>.made,
            text               => ~$/,
        )
    }

    method pat:sym<s>($/) {
        make PatQualifiedPath.new(
            ty-sum              =>  $<ty-sum>.made,
            maybe-as-trait-refA =>  $<maybe-as-trait-ref>>>.made[0],
            identA              =>  $<ident>>>.made[0],
            maybe-as-trait-refB =>  $<maybe-as-trait-ref>>>.made[1],
            identB              =>  $<ident>>>.made[1],
            text                => ~$/,
        )
    }

    method pats-or($/) {
        make $<pat>>>.made
    }
}

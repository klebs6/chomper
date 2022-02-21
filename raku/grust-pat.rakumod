our class PatEnum {
    has $.path_expr;
    has $.pat_tup;
}

our class PatIdent {
    has $.pat;
    has $.ident;
    has $.binding_mode;
}

our class PatMac {
    has $.maybe_ident;
    has $.path_expr;
    has $.delimited_token_trees;
}

our class PatQualifiedPath {
    has $.maybe_as_trait_ref;
    has $.ident;
    has $.ty_sum;
}

our class PatRange {
    has $.lit_or_path;
}

our class PatRegion {
    has $.pat;
}

our class PatStruct {
    has $.pat_fields;
    has $.pat_struct;
    has $.path_expr;
}

our class PatTup {
    has $.pat_tup;
    has $.pat_tup_elts;
}

our class PatUniq {
    has $.pat;
}

our class PatVec {
    has $.pat_vec;
    has $.pat_vec_elts;
}

our class Pats {
    has $.pat;
}

our class Pat::G {

    proto rule pat { * }

    rule pat:sym<a> {
        <UNDERSCORE>
    }

    rule pat:sym<b> {
        '&' <pat>
    }

    rule pat:sym<c> {
        '&' <MUT> <pat>
    }

    rule pat:sym<d> {
        <ANDAND> <pat>
    }

    rule pat:sym<e> {
        '(' ')'
    }

    rule pat:sym<f> {
        '(' <pat-tup> ')'
    }

    rule pat:sym<g> {
        '[' <pat-vec> ']'
    }

    rule pat:sym<h> {
        <lit-or_path>
    }

    rule pat:sym<i> {
        <lit-or_path> <DOTDOTDOT> <lit-or_path>
    }

    rule pat:sym<j> {
        <path-expr> '{' <pat-struct> '}'
    }

    rule pat:sym<k> {
        <path-expr> '(' ')'
    }

    rule pat:sym<l> {
        <path-expr> '(' <pat-tup> ')'
    }

    rule pat:sym<m> {
        <path-expr> '!' <maybe-ident> <delimited-token_trees>
    }

    rule pat:sym<n> {
        <binding-mode> <ident>
    }

    rule pat:sym<o> {
        <ident> '@' <pat>
    }

    rule pat:sym<p> {
        <binding-mode> <ident> '@' <pat>
    }

    rule pat:sym<q> {
        <BOX> <pat>
    }

    rule pat:sym<r> {
        '<' <ty-sum> <maybe-as_trait_ref> '>' <MOD-SEP> <ident>
    }

    rule pat:sym<s> {
        <SHL> <ty-sum> <maybe-as_trait_ref> '>' <MOD-SEP> <ident> <maybe-as_trait_ref> '>' <MOD-SEP> <ident>
    }

    proto rule pats-or { * }

    rule pats-or:sym<a> {
        <pat>
    }

    rule pats-or:sym<b> {
        <pats-or> '|' <pat>
    }
}

our class Pat::A {

    method pat:sym<a>($/) {
        make PatWild.new
    }

    method pat:sym<b>($/) {
        make PatRegion.new(
            pat =>  $<pat>.made,
        )
    }

    method pat:sym<c>($/) {
        make PatRegion.new(
            pat =>  $<pat>.made,
        )
    }

    method pat:sym<d>($/) {
        make PatRegion.new(

        )
    }

    method pat:sym<e>($/) {
        make PatUnit.new
    }

    method pat:sym<f>($/) {
        make PatTup.new(
            pat-tup =>  $<pat-tup>.made,
        )
    }

    method pat:sym<g>($/) {
        make PatVec.new(
            pat-vec =>  $<pat-vec>.made,
        )
    }

    method pat:sym<h>($/) {
        make $<lit-or_path>.made
    }

    method pat:sym<i>($/) {
        make PatRange.new(
            lit-or_path =>  $<lit-or_path>.made,
            lit-or_path =>  $<lit-or_path>.made,
        )
    }

    method pat:sym<j>($/) {
        make PatStruct.new(
            path-expr  =>  $<path-expr>.made,
            pat-struct =>  $<pat-struct>.made,
        )
    }

    method pat:sym<k>($/) {
        make PatEnum.new(
            path-expr =>  $<path-expr>.made,
        )
    }

    method pat:sym<l>($/) {
        make PatEnum.new(
            path-expr =>  $<path-expr>.made,
            pat-tup   =>  $<pat-tup>.made,
        )
    }

    method pat:sym<m>($/) {
        make PatMac.new(
            path-expr             =>  $<path-expr>.made,
            maybe-ident           =>  $<maybe-ident>.made,
            delimited-token_trees =>  $<delimited-token_trees>.made,
        )
    }

    method pat:sym<n>($/) {
        make PatIdent.new(
            binding-mode =>  $<binding-mode>.made,
            ident        =>  $<ident>.made,
        )
    }

    method pat:sym<o>($/) {
        make PatIdent.new(
            ident =>  $<ident>.made,
            pat   =>  $<pat>.made,
        )
    }

    method pat:sym<p>($/) {
        make PatIdent.new(
            binding-mode =>  $<binding-mode>.made,
            ident        =>  $<ident>.made,
            pat          =>  $<pat>.made,
        )
    }

    method pat:sym<q>($/) {
        make PatUniq.new(
            pat =>  $<pat>.made,
        )
    }

    method pat:sym<r>($/) {
        make PatQualifiedPath.new(
            ty-sum             =>  $<ty-sum>.made,
            maybe-as_trait_ref =>  $<maybe-as_trait_ref>.made,
            ident              =>  $<ident>.made,
        )
    }

    method pat:sym<s>($/) {
        make PatQualifiedPath.new(
            maybe-as_trait_ref =>  $<maybe-as_trait_ref>.made,
            ident              =>  $<ident>.made,
        )
    }

    method pats-or:sym<a>($/) {
        make Pats.new(
            pat =>  $<pat>.made,
        )
    }

    method pats-or:sym<b>($/) {
        ExtNode<140665525299992>
    }
}

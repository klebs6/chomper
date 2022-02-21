our class PatVecElts {
    has $.pat;
}

our class PatVec::Rules {

    proto rule pat-vec { * }

    rule pat-vec:sym<a> {
        <pat-vec_elts>
    }

    rule pat-vec:sym<b> {
        <pat-vec_elts> ','
    }

    rule pat-vec:sym<c> {
        <pat-vec_elts> <DOTDOT>
    }

    rule pat-vec:sym<d> {
        <pat-vec_elts> ',' <DOTDOT>
    }

    rule pat-vec:sym<e> {
        <pat-vec_elts> <DOTDOT> ',' <pat-vec_elts>
    }

    rule pat-vec:sym<f> {
        <pat-vec_elts> <DOTDOT> ',' <pat-vec_elts> ','
    }

    rule pat-vec:sym<g> {
        <pat-vec_elts> ',' <DOTDOT> ',' <pat-vec_elts>
    }

    rule pat-vec:sym<h> {
        <pat-vec_elts> ',' <DOTDOT> ',' <pat-vec_elts> ','
    }

    rule pat-vec:sym<i> {
        <DOTDOT> ',' <pat-vec_elts>
    }

    rule pat-vec:sym<j> {
        <DOTDOT> ',' <pat-vec_elts> ','
    }

    rule pat-vec:sym<k> {
        <DOTDOT>
    }

    rule pat-vec:sym<l> {

    }

    proto rule pat-vec_elts { * }

    rule pat-vec_elts:sym<a> {
        <pat>
    }

    rule pat-vec_elts:sym<b> {
        <pat-vec_elts> ',' <pat>
    }
}

our class PatVec::Actions {

    method pat-vec:sym<a>($/) {
        make PatVec.new(
            pat-vec_elts =>  $<pat-vec_elts>.made,
        )
    }

    method pat-vec:sym<b>($/) {
        make PatVec.new(
            pat-vec_elts =>  $<pat-vec_elts>.made,
        )
    }

    method pat-vec:sym<c>($/) {
        make PatVec.new(
            pat-vec_elts =>  $<pat-vec_elts>.made,
        )
    }

    method pat-vec:sym<d>($/) {
        make PatVec.new(
            pat-vec_elts =>  $<pat-vec_elts>.made,
        )
    }

    method pat-vec:sym<e>($/) {
        make PatVec.new(
            pat-vec_elts =>  $<pat-vec_elts>.made,
            pat-vec_elts =>  $<pat-vec_elts>.made,
        )
    }

    method pat-vec:sym<f>($/) {
        make PatVec.new(
            pat-vec_elts =>  $<pat-vec_elts>.made,
            pat-vec_elts =>  $<pat-vec_elts>.made,
        )
    }

    method pat-vec:sym<g>($/) {
        make PatVec.new(
            pat-vec_elts =>  $<pat-vec_elts>.made,
            pat-vec_elts =>  $<pat-vec_elts>.made,
        )
    }

    method pat-vec:sym<h>($/) {
        make PatVec.new(
            pat-vec_elts =>  $<pat-vec_elts>.made,
            pat-vec_elts =>  $<pat-vec_elts>.made,
        )
    }

    method pat-vec:sym<i>($/) {
        make PatVec.new(
            pat-vec_elts =>  $<pat-vec_elts>.made,
        )
    }

    method pat-vec:sym<j>($/) {
        make PatVec.new(
            pat-vec_elts =>  $<pat-vec_elts>.made,
        )
    }

    method pat-vec:sym<k>($/) {
        make PatVec.new(

        )
    }

    method pat-vec:sym<l>($/) {
        make PatVec.new(

        )
    }

    method pat-vec_elts:sym<a>($/) {
        make PatVecElts.new(
            pat =>  $<pat>.made,
        )
    }

    method pat-vec_elts:sym<b>($/) {
        ExtNode<140470254776616>
    }
}

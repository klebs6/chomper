our class PatTupElts {
    has $.pat;
}

our class PatTup::Rules {

    proto rule pat-tup { * }

    rule pat-tup:sym<a> {
        <pat-tup_elts>
    }

    rule pat-tup:sym<b> {
        <pat-tup_elts> ','
    }

    rule pat-tup:sym<c> {
        <pat-tup_elts> <DOTDOT>
    }

    rule pat-tup:sym<d> {
        <pat-tup_elts> ',' <DOTDOT>
    }

    rule pat-tup:sym<e> {
        <pat-tup_elts> <DOTDOT> ',' <pat-tup_elts>
    }

    rule pat-tup:sym<f> {
        <pat-tup_elts> <DOTDOT> ',' <pat-tup_elts> ','
    }

    rule pat-tup:sym<g> {
        <pat-tup_elts> ',' <DOTDOT> ',' <pat-tup_elts>
    }

    rule pat-tup:sym<h> {
        <pat-tup_elts> ',' <DOTDOT> ',' <pat-tup_elts> ','
    }

    rule pat-tup:sym<i> {
        <DOTDOT> ',' <pat-tup_elts>
    }

    rule pat-tup:sym<j> {
        <DOTDOT> ',' <pat-tup_elts> ','
    }

    rule pat-tup:sym<k> {
        <DOTDOT>
    }

    proto rule pat-tup_elts { * }

    rule pat-tup_elts:sym<a> {
        <pat>
    }

    rule pat-tup_elts:sym<b> {
        <pat-tup_elts> ',' <pat>
    }
}

our class PatTup::Actions {

    method pat-tup:sym<a>($/) {
        make PatTup.new(
            pat-tup_elts =>  $<pat-tup_elts>.made,
        )
    }

    method pat-tup:sym<b>($/) {
        make PatTup.new(
            pat-tup_elts =>  $<pat-tup_elts>.made,
        )
    }

    method pat-tup:sym<c>($/) {
        make PatTup.new(
            pat-tup_elts =>  $<pat-tup_elts>.made,
        )
    }

    method pat-tup:sym<d>($/) {
        make PatTup.new(
            pat-tup_elts =>  $<pat-tup_elts>.made,
        )
    }

    method pat-tup:sym<e>($/) {
        make PatTup.new(
            pat-tup_elts =>  $<pat-tup_elts>.made,
            pat-tup_elts =>  $<pat-tup_elts>.made,
        )
    }

    method pat-tup:sym<f>($/) {
        make PatTup.new(
            pat-tup_elts =>  $<pat-tup_elts>.made,
            pat-tup_elts =>  $<pat-tup_elts>.made,
        )
    }

    method pat-tup:sym<g>($/) {
        make PatTup.new(
            pat-tup_elts =>  $<pat-tup_elts>.made,
            pat-tup_elts =>  $<pat-tup_elts>.made,
        )
    }

    method pat-tup:sym<h>($/) {
        make PatTup.new(
            pat-tup_elts =>  $<pat-tup_elts>.made,
            pat-tup_elts =>  $<pat-tup_elts>.made,
        )
    }

    method pat-tup:sym<i>($/) {
        make PatTup.new(
            pat-tup_elts =>  $<pat-tup_elts>.made,
        )
    }

    method pat-tup:sym<j>($/) {
        make PatTup.new(
            pat-tup_elts =>  $<pat-tup_elts>.made,
        )
    }

    method pat-tup:sym<k>($/) {
        make PatTup.new(

        )
    }

    method pat-tup_elts:sym<a>($/) {
        make PatTupElts.new(
            pat =>  $<pat>.made,
        )
    }

    method pat-tup_elts:sym<b>($/) {
        ExtNode<140176894415400>
    }
}

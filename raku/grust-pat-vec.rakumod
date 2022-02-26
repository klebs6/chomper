our class PatVecElts {
    has $.pat;
}

our class PatVec::Rules {

    proto rule pat-vec { * }

    rule pat-vec:sym<d> { <pat-vec_elts> ','? <DOTDOT>? }
    rule pat-vec:sym<h> { <pat-vec_elts> ','? <DOTDOT> ',' <pat-vec_elts> ','? }
    rule pat-vec:sym<j> { [<DOTDOT> [',' <pat-vec_elts> ','?]?]? }

    rule pat-vec_elts { <pat>+ %% "," }
}

our class PatVec::Actions {

    method pat-vec:sym<d>($/) {
        make PatVec.new(
            pat-vec_elts =>  $<pat-vec_elts>.made,
        )
    }

    method pat-vec:sym<h>($/) {
        make PatVec.new(
            pat-vec_elts =>  $<pat-vec_elts>.made,
            pat-vec_elts =>  $<pat-vec_elts>.made,
        )
    }

    method pat-vec:sym<j>($/) {
        make PatVec.new(
            pat-vec_elts =>  $<pat-vec_elts>.made,
        )
    }

    method pat-vec_elts($/) {
        make $<pat>.made
    }
}

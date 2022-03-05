use grust-model;

our role PatVec::Rules {

    proto rule pat-vec { * }

    rule pat-vec:sym<d> { <pat-vec-elts> ','? <tok-dotdot>? }
    rule pat-vec:sym<h> { <pat-vec-elts> ','? <tok-dotdot> ',' <pat-vec-elts> ','? }
    rule pat-vec:sym<j> { [<tok-dotdot> [',' <pat-vec-elts> ','?]?]? }

    rule pat-vec-elts { <pat>+ %% "," }
}

our role PatVec::Actions {

    method pat-vec:sym<d>($/) {
        make PatVec.new(
            pat-vec-elts => $<pat-vec-elts>.made,
            text         => ~$/,
        )
    }

    method pat-vec:sym<h>($/) {
        make PatVec.new(
            pat-vec-elts => [
                $<pat-vec-elts>>>.made[0],
                $<pat-vec-elts>>>.made[1],
            ]
        )
    }

    method pat-vec:sym<j>($/) {
        make PatVec.new(
            pat-vec-elts =>  $<pat-vec-elts>.made,
            text         => ~$/,
        )
    }

    method pat-vec-elts($/) {
        make $<pat>>>.made
    }
}

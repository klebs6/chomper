our class PatVec {
    has $.pat-vec;
    has $.pat-vec-elts;

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

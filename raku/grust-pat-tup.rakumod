use grust-model;


our role PatTup::Rules {

    proto rule pat-tup { * }

    rule pat-tup:sym<a> { <pat-tup-elts> ','? <DOTDOT>? }
    rule pat-tup:sym<b> { <pat-tup-elts> ','? <DOTDOT> ',' <pat-tup-elts> ','? }
    rule pat-tup:sym<c> { <DOTDOT> [',' <pat-tup-elts> ','?]? }

    rule pat-tup-elts { <pat>+ %% "," }
}

our role PatTup::Actions {

    method pat-tup:sym<a>($/) {
        make PatTup.new(
            pat-tup-elts =>  $<pat-tup-elts>.made,
        )
    }

    method pat-tup:sym<b>($/) {
        make PatTup.new(
            pat-tup-elts =>  $<pat-tup-elts>.made,
            pat-tup-elts =>  $<pat-tup-elts>.made,
        )
    }

    method pat-tup:sym<c>($/) {
        make PatTup.new(
            pat-tup-elts =>  $<pat-tup-elts>.made,
        )
    }

    method pat-tup-elts($/) {
        make $<pat>>>.made
    }
}


use grust-model;

our role PatTup::Rules {

    proto rule pat-tup { * }

    rule pat-tup:sym<a> { <pat-tup-elts> ','? <tok-dotdot>? }
    rule pat-tup:sym<b> { <pat-tup-elts> ','? <tok-dotdot> ',' <pat-tup-elts> ','? }
    rule pat-tup:sym<c> { <tok-dotdot> [',' <pat-tup-elts> ','?]? }

    rule pat-tup-elts { <pat>+ %% "," }
}

our role PatTup::Actions {

    method pat-tup:sym<a>($/) {
        make $<pat-tup-elts>.made
    }

    method pat-tup:sym<b>($/) {
        make [
            $<pat-tup-elts>>>.made[0],
            $<pat-tup-elts>>>.made[1],
        ]
    }

    method pat-tup:sym<c>($/) {
        make $<pat-tup-elts>.made
    }

    method pat-tup-elts($/) {
        make $<pat>>>.made
    }
}

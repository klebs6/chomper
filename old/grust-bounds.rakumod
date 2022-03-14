use Data::Dump::Tree;

our role Bounds::Rules {

    rule maybe-bounds {
        #{self.set-prec(SHIFTPLUS)} 
        [':' <bounds>]?
    }

    #--------------------------
    rule bounds {  
        <bound>+ %% '+'
    }

    proto rule bound { * }
    rule bound:sym<lifetime>      { <lifetime> }
    rule bound:sym<trait-ref>     { <trait-ref> }
}

our role Bounds::Actions {

    method maybe-bounds($/) {
        make $<bounds>.made
    }

    method bounds($/) {
        make $<bound>>>.made,
    }

    method bound:sym<lifetime>($/)  { make $<lifetime>.made }
    method bound:sym<trait-ref>($/) { make $<trait-ref>.made }
}
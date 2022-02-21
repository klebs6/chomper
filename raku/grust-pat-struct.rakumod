our class PatStruct::G {

    proto rule pat-struct { * }

    rule pat-struct:sym<a> {
        <pat-fields>
    }

    rule pat-struct:sym<b> {
        <pat-fields> ','
    }

    rule pat-struct:sym<c> {
        <pat-fields> ',' <DOTDOT>
    }

    rule pat-struct:sym<d> {
        <DOTDOT>
    }

    rule pat-struct:sym<e> {

    }
}

our class PatStruct::A {

    method pat-struct:sym<a>($/) {
        make PatStruct.new(
            pat-fields =>  $<pat-fields>.made,
        )
    }

    method pat-struct:sym<b>($/) {
        make PatStruct.new(
            pat-fields =>  $<pat-fields>.made,
        )
    }

    method pat-struct:sym<c>($/) {
        make PatStruct.new(
            pat-fields =>  $<pat-fields>.made,
        )
    }

    method pat-struct:sym<d>($/) {
        make PatStruct.new(

        )
    }

    method pat-struct:sym<e>($/) {
        make PatStruct.new(

        )
    }
}

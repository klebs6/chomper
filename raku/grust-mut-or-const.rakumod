our class MutOrConst::G {

    proto rule maybe-mut { * }

    rule maybe-mut:sym<a> {
        <MUT>
    }

    rule maybe-mut:sym<b> {
        # %prec MUT 
    }

    proto rule maybe-mut_or_const { * }

    rule maybe-mut_or_const:sym<a> {
        <MUT>
    }

    rule maybe-mut_or_const:sym<b> {
        <CONST>
    }

    rule maybe-mut_or_const:sym<c> {

    }
}

our class MutOrConst::A {

    method maybe-mut:sym<a>($/) {
        make MutMutable.new
    }

    method maybe-mut:sym<b>($/) {
        make MutImmutable.new
    }

    method maybe-mut_or_const:sym<a>($/) {
        make MutMutable.new
    }

    method maybe-mut_or_const:sym<b>($/) {
        make MutImmutable.new
    }

    method maybe-mut_or_const:sym<c>($/) {
        make MutImmutable.new
    }
}

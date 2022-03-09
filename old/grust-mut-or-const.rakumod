use Data::Dump::Tree;

our class MutMutable { 

    has $.text;

    method gist {
        "mut"
    }
}

our class MutImmutable { 

    has $.text;

    method gist {
        ""
    }
}

our role MutOrConst::Rules {

    rule maybe-mut          { <kw-mut>? }
    rule maybe-mut-or-const { [<kw-mut> | <kw-const>]? }
}

our role MutOrConst::Actions {

    method maybe-mut($/) { 
        if $/<kw-mut>:exists {
            make MutMutable.new(
                text => ~$/,
            )
        } else {
            make MutImmutable.new(
                text => ~$/,
            )
        }
    }

    method maybe-mut-or-const($/) { 
        if $/<kw-mut>:exists {
            make MutMutable.new(
                text => ~$/,
            )
        } else {
            make MutImmutable.new(
                text => ~$/,
            )
        }
    }
}

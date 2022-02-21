our class Visibility::G {

    proto rule visibility { * }

    rule visibility:sym<a> {
        <PUB>
    }

    rule visibility:sym<b> {

    }
}

our class Visibility::A {

    method visibility:sym<a>($/) {
        make Public.new
    }

    method visibility:sym<b>($/) {
        make Inherited.new
    }
}


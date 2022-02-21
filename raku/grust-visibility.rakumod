our class Visibility::Rules {

    proto rule visibility { * }

    rule visibility:sym<a> {
        <PUB>
    }

    rule visibility:sym<b> {

    }
}

our class Visibility::Actions {

    method visibility:sym<a>($/) {
        make Public.new
    }

    method visibility:sym<b>($/) {
        make Inherited.new
    }
}


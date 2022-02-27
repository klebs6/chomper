use grust-model;

our role Visibility::Rules {

    proto rule visibility { * }

    rule visibility:sym<a> { <PUB> }
    rule visibility:sym<b> { }
}

our role Visibility::Actions {

    method visibility:sym<a>($/) { make Public.new }
    method visibility:sym<b>($/) { make Inherited.new }
}


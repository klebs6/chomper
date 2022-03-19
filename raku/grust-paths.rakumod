use Data::Dump::Tree;

our class SimplePath {
    has @.simple-path-segments;

    has $.text;

    method gist {
        @.simple-path-segments>>.gist.join("::")
    }
}

our role SimplePath::Rules {

    token simple-path {
        <tok-path-sep>?
        [<simple-path-segment>+ % <tok-path-sep>]
    }

    proto token simple-path-segment { * }
    token simple-path-segment:sym<ident>   { <identifier> }
    token simple-path-segment:sym<super>   { <kw-super> }
    token simple-path-segment:sym<self>    { <kw-selfvalue> }
    token simple-path-segment:sym<crate>   { <kw-crate> }
    token simple-path-segment:sym<$-crate> { <dollar-crate> }
}

our role SimplePath::Actions {

    method simple-path($/) {
        make SimplePath.new(
            simple-path-segments => $<simple-path-segment>>>.made,
            text                 => $/.Str,
        )
    }

    method simple-path-segment:sym<ident>($/)   { make ~$/ }
    method simple-path-segment:sym<super>($/)   { make ~$/ }
    method simple-path-segment:sym<self>($/)    { make ~$/ }
    method simple-path-segment:sym<crate>($/)   { make ~$/ }
    method simple-path-segment:sym<$-crate>($/) { make ~$/ }
}

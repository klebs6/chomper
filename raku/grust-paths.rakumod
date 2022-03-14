our class SimplePath {
    has @.simple-path-segments;

    has $.text;

    submethod TWEAK {
        say self.gist;
    }

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our role SimplePath::Rules {

    token simple-path {
        <tok-path-sep>?
        [
            <simple-path-segment>
            [
                <tok-path-sep>
                <simple-path-segment>
            ]*
        ]
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
        <tok-path-sep>?
        [
            <simple-path-segment>
            [
                <tok-path-sep>
                <simple-path-segment>
            ]*
        ]
    }

    method simple-path-segment:sym<ident>($/)   { <identifier> }
    method simple-path-segment:sym<super>($/)   { <kw-super> }
    method simple-path-segment:sym<self>($/)    { <kw-selfvalue> }
    method simple-path-segment:sym<crate>($/)   { <kw-crate> }
    method simple-path-segment:sym<$-crate>($/) { <dollar-crate> }
}

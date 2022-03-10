our role SimplePath::Rules {

    token simple-path {
        <tok-path-sep>?
        [
            <simple-path-segment>+ %% <tok-path-sep>
        ]
    }

    proto token simple-path-segment { * }
    token simple-path-segment:sym<ident>   { <identifier> }
    token simple-path-segment:sym<super>   { <kw-super> }
    token simple-path-segment:sym<self>    { <kw-selfvalue> }
    token simple-path-segment:sym<crate>   { <kw-crate> }
    token simple-path-segment:sym<$-crate> { <tok-dollar> <kw-crate> }
}

our role SimplePath::Actions {}

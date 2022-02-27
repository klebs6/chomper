our class ViewPathGlob {
    has $.path_no_types_allowed;
}

our class ViewPathList {
    has $.idents_or_self;
    has $.path_no_types_allowed;
}

our class ViewPathSimple {
    has $.path_no_types_allowed;
    has $.ident;
}

our class ViewPath::Rules {

    proto rule view-path { * }

    rule view-path:sym<a> { <path-no_types_allowed> }
    rule view-path:sym<b> { <path-no_types_allowed> <MOD-SEP> '{' '}' }
    rule view-path:sym<c> { <MOD-SEP> '{' '}' }
    rule view-path:sym<d> { <path-no_types_allowed> <MOD-SEP> '{' <idents-or_self> '}' }
    rule view-path:sym<e> { <MOD-SEP> '{' <idents-or_self> '}' }
    rule view-path:sym<f> { <path-no_types_allowed> <MOD-SEP> '{' <idents-or_self> ',' '}' }
    rule view-path:sym<g> { <MOD-SEP> '{' <idents-or_self> ',' '}' }
    rule view-path:sym<h> { <path-no_types_allowed> <MOD-SEP> '*' }
    rule view-path:sym<i> { <MOD-SEP> '*' }
    rule view-path:sym<j> { '*' }
    rule view-path:sym<k> { '{' '}' }
    rule view-path:sym<l> { '{' <idents-or_self> '}' }
    rule view-path:sym<m> { '{' <idents-or_self> ',' '}' }
    rule view-path:sym<n> { <path-no_types_allowed> <AS> <ident> }
}

our class ViewPath::Actions {

    method view-path:sym<a>($/) {
        make ViewPathSimple.new(
            path-no_types_allowed =>  $<path-no_types_allowed>.made,
        )
    }

    method view-path:sym<b>($/) {
        make ViewPathList.new(
            path-no_types_allowed =>  $<path-no_types_allowed>.made,
        )
    }

    method view-path:sym<c>($/) {
        make ViewPathList.new(

        )
    }

    method view-path:sym<d>($/) {
        make ViewPathList.new(
            path-no_types_allowed =>  $<path-no_types_allowed>.made,
            idents-or_self        =>  $<idents-or_self>.made,
        )
    }

    method view-path:sym<e>($/) {
        make ViewPathList.new(
            idents-or_self =>  $<idents-or_self>.made,
        )
    }

    method view-path:sym<f>($/) {
        make ViewPathList.new(
            path-no_types_allowed =>  $<path-no_types_allowed>.made,
            idents-or_self        =>  $<idents-or_self>.made,
        )
    }

    method view-path:sym<g>($/) {
        make ViewPathList.new(
            idents-or_self =>  $<idents-or_self>.made,
        )
    }

    method view-path:sym<h>($/) {
        make ViewPathGlob.new(
            path-no_types_allowed =>  $<path-no_types_allowed>.made,
        )
    }

    method view-path:sym<i>($/) {
        make ViewPathGlob.new
    }

    method view-path:sym<j>($/) {
        make ViewPathGlob.new
    }

    method view-path:sym<k>($/) {
        make ViewPathListEmpty.new
    }

    method view-path:sym<l>($/) {
        make ViewPathList.new(
            idents-or_self =>  $<idents-or_self>.made,
        )
    }

    method view-path:sym<m>($/) {
        make ViewPathList.new(
            idents-or_self =>  $<idents-or_self>.made,
        )
    }

    method view-path:sym<n>($/) {
        make ViewPathSimple.new(
            path-no_types_allowed =>  $<path-no_types_allowed>.made,
            ident                 =>  $<ident>.made,
        )
    }
}


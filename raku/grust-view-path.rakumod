use grust-model;

our role ViewPath::Rules {

    proto rule view-path { * }

    rule view-path:sym<a> { <path-no-types-allowed> }
    rule view-path:sym<b> { <path-no-types-allowed> <mod-sep> '{' '}' }
    rule view-path:sym<c> { <mod-sep> '{' '}' }
    rule view-path:sym<d> { <path-no-types-allowed> <mod-sep> '{' <idents-or-self> '}' }
    rule view-path:sym<e> { <mod-sep> '{' <idents-or-self> '}' }
    rule view-path:sym<f> { <path-no-types-allowed> <mod-sep> '{' <idents-or-self> ',' '}' }
    rule view-path:sym<g> { <mod-sep> '{' <idents-or-self> ',' '}' }
    rule view-path:sym<h> { <path-no-types-allowed> <mod-sep> '*' }
    rule view-path:sym<i> { <mod-sep> '*' }
    rule view-path:sym<j> { '*' }
    rule view-path:sym<k> { '{' '}' }
    rule view-path:sym<l> { '{' <idents-or-self> '}' }
    rule view-path:sym<m> { '{' <idents-or-self> ',' '}' }
    rule view-path:sym<n> { <path-no-types-allowed> <kw-as> <ident> }
}

our role ViewPath::Actions {

    method view-path:sym<a>($/) {
        make ViewPathSimple.new(
            path-no-types-allowed =>  $<path-no-types-allowed>.made,
        )
    }

    method view-path:sym<b>($/) {
        make ViewPathList.new(
            path-no-types-allowed =>  $<path-no-types-allowed>.made,
        )
    }

    method view-path:sym<c>($/) {
        make ViewPathList.new(

        )
    }

    method view-path:sym<d>($/) {
        make ViewPathList.new(
            path-no-types-allowed =>  $<path-no-types-allowed>.made,
            idents-or-self        =>  $<idents-or-self>.made,
        )
    }

    method view-path:sym<e>($/) {
        make ViewPathList.new(
            idents-or-self =>  $<idents-or-self>.made,
        )
    }

    method view-path:sym<f>($/) {
        make ViewPathList.new(
            path-no-types-allowed =>  $<path-no-types-allowed>.made,
            idents-or-self        =>  $<idents-or-self>.made,
        )
    }

    method view-path:sym<g>($/) {
        make ViewPathList.new(
            idents-or-self =>  $<idents-or-self>.made,
        )
    }

    method view-path:sym<h>($/) {
        make ViewPathGlob.new(
            path-no-types-allowed =>  $<path-no-types-allowed>.made,
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
            idents-or-self =>  $<idents-or-self>.made,
        )
    }

    method view-path:sym<m>($/) {
        make ViewPathList.new(
            idents-or-self =>  $<idents-or-self>.made,
        )
    }

    method view-path:sym<n>($/) {
        make ViewPathSimple.new(
            path-no-types-allowed =>  $<path-no-types-allowed>.made,
            ident                 =>  $<ident>.made,
        )
    }
}

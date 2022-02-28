use grust-model;

our role NamedArg::Rules {

    proto rule named-arg { * }
    rule named-arg:sym<a> { <ident> }
    rule named-arg:sym<b> { <underscore> }
    rule named-arg:sym<c> { '&' <ident> }
    rule named-arg:sym<d> { '&' <underscore> }
    rule named-arg:sym<e> { <andand> <ident> }
    rule named-arg:sym<f> { <andand> <underscore> }
    rule named-arg:sym<g> { <mut> <ident> }
}

our role NamedArg::Actions {

    method named-arg:sym<a>($/) { make $<ident>.made }
    method named-arg:sym<b>($/) { make PatWild.new }
    method named-arg:sym<c>($/) { make $<ident>.made }
    method named-arg:sym<d>($/) { make PatWild.new }
    method named-arg:sym<e>($/) { make $<ident>.made }
    method named-arg:sym<f>($/) { make PatWild.new }
    method named-arg:sym<g>($/) { make $<ident>.made }
}

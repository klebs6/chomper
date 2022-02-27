use grust-model;

our role NamedArg::Rules {

    proto rule named-arg { * }
    rule named-arg:sym<a> { <ident> }
    rule named-arg:sym<b> { <UNDERSCORE> }
    rule named-arg:sym<c> { '&' <ident> }
    rule named-arg:sym<d> { '&' <UNDERSCORE> }
    rule named-arg:sym<e> { <ANDAND> <ident> }
    rule named-arg:sym<f> { <ANDAND> <UNDERSCORE> }
    rule named-arg:sym<g> { <MUT> <ident> }
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

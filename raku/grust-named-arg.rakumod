our class PatWild { 

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

our role NamedArg::Rules {

    proto rule named-arg { * }
    rule named-arg:sym<a> { <ident> }
    rule named-arg:sym<b> { <tok-underscore> }
    rule named-arg:sym<c> { '&' <ident> }
    rule named-arg:sym<d> { '&' <tok-underscore> }
    rule named-arg:sym<e> { <tok-andand> <ident> }
    rule named-arg:sym<f> { <tok-andand> <tok-underscore> }
    rule named-arg:sym<g> { <kw-mut> <ident> }
}

our role NamedArg::Actions {

    method named-arg:sym<a>($/) { make $<ident>.made }
    method named-arg:sym<b>($/) { make PatWild.new( text => ~$/ ) }
    method named-arg:sym<c>($/) { make $<ident>.made }
    method named-arg:sym<d>($/) { make PatWild.new( text => ~$/ ) }
    method named-arg:sym<e>($/) { make $<ident>.made }
    method named-arg:sym<f>($/) { make PatWild.new( text => ~$/ ) }
    method named-arg:sym<g>($/) { make $<ident>.made }
}

use Data::Dump::Tree;

our class Binding {
    has $.ty;
    has $.ident;

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

our class BindByRef {
    has Bool $.mut;

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

our class BindByValue {
    has Bool $.mut;

    has $.text;

    method gist {
        if $.mut {
            "mut"
        } else {
            ""
        }
    }
}

our role Binding::Rules {

    rule bindings {
        <binding>+ %% <tok-comma>
    }

    rule binding {
        <ident> '=' <ty>
    }
}

our role Binding::Actions {

    method bindings($/) {
        make $<binding>>>.made
    }

    method binding($/) {
        make Binding.new(
            ident => $<ident>.made,
            ty    => $<ty>.made,
            text  => ~$/,
        )
    }
}

#----------------------------
our role BindingMode::Rules {

    proto rule binding-mode { * }
    rule binding-mode:sym<ref-mut> { <kw-ref> <kw-mut> }
    rule binding-mode:sym<kw-ref>  { <kw-ref> }
    rule binding-mode:sym<kw-mut>  { <kw-mut> }
}

our role BindingMode::Actions {

    method binding-mode:sym<kw-ref>($/)  { make BindByRef.new(  text => ~$/, mut => False) }
    method binding-mode:sym<ref-mut>($/) { make BindByRef.new(  text => ~$/, mut => True) }
    method binding-mode:sym<kw-mut>($/)  { make BindByValue.new(text => ~$/, mut => True) }
}


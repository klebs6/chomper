use Data::Dump::Tree;
use grust-model-expr;

our class IdentsOrSelf {
    has $.idents-or-self;
    has $.ident-or-self;
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

our class As {
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

our role IdentsOrSelf::Rules {

    rule idents-or-self {
        <ident-or-self> 
        <idents-or-self-tail>* 
    }

    proto rule idents-or-self-tail  { * }
    rule idents-or-self-tail:sym<a> { <kw-as> <ident> }
    rule idents-or-self-tail:sym<b> { ',' <ident-or-self> }

    proto rule ident-or-self        { * }
    rule ident-or-self:sym<ident>   { <ident> }
    rule ident-or-self:sym<self>    { <kw-self>  }
}

our role IdentsOrSelf::Actions {

    method idents-or-self($/) {
        make IdentsOrSelf.new(
            ident-or-self => $<ident-or-self>.made,
            tail          => $<idents-or-self-tail>>>.made,
            text          => ~$/,
        )
    }

    method idents-or-self-tail:sym<a>($/) {
        make As.new(
            ident => $<ident>.made,
            text  => ~$/,
        )
    }

    method idents-or-self-tail:sym<b>($/) {
        make $<ident-or-self>.made
    }

    method ident-or-self:sym<ident>($/) { make $<ident>.made }
    method ident-or-self:sym<self>($/)  { make Self.new }
}

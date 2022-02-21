our class IdentsOrSelf {
    has $.idents_or_self;
    has $.ident_or_self;
    has $.ident;
}

our class IdentsOrSelf::G {

    proto rule idents-or_self { * }

    rule idents-or_self:sym<a> {
        <ident-or_self>
    }

    rule idents-or_self:sym<b> {
        <idents-or_self> <AS> <ident>
    }

    rule idents-or_self:sym<c> {
        <idents-or_self> ',' <ident-or_self>
    }

    proto rule ident-or_self { * }

    rule ident-or_self:sym<a> {
        <ident>
    }

    rule ident-or_self:sym<b> {
        <SELF>
    }
}

our class IdentsOrSelf::A {

    method idents-or_self:sym<a>($/) {
        make IdentsOrSelf.new(
            ident-or_self =>  $<ident-or_self>.made,
        )
    }

    method idents-or_self:sym<b>($/) {
        make IdentsOrSelf.new(
            idents-or_self =>  $<idents-or_self>.made,
            ident          =>  $<ident>.made,
        )
    }

    method idents-or_self:sym<c>($/) {
        ExtNode<140683188573432>
    }

    method ident-or_self:sym<a>($/) {
        make $<ident>.made
    }

    method ident-or_self:sym<b>($/) {
        make yytext.new
    }
}


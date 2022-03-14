our class Crate {
    has @.inner-attributes;
    has @.crate-items;

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

our class AsClause {
    has $.identifier-or-underscore;

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

our class ExternCrate {
    has $.crate-ref;
    has $.maybe-as-clause;

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

our class ModuleSemi {
    has Bool $.unsafe;
    has $.identifier;

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

our class ModuleBlock {
    has Bool $.unsafe;
    has $.identifier;
    has @.inner-attributes;
    has @.crate-items;

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

our role Crate::Rules {

    rule crate {
        <utf8-bom>?
        <shebang>?
        <inner-attribute>*
        <crate-item>*
    }

    token utf8-bom {
        \x[FEFF]
    }

    token shebang {
        <tok-shebang> \N+
    }

    rule as-clause {
        <kw-as>
        <identifier-or-underscore>
    }

    rule extern-crate {
        <kw-extern>
        <kw-crate>
        <crate-ref>
        <as-clause>?
        <tok-semi>
    }

    proto rule crate-ref { * }

    rule crate-ref:sym<id>   { <identifier> }
    rule crate-ref:sym<self> { <kw-selfvalue> }

    #-------------------------
    proto rule module { * }

    rule module:sym<semi> {
        <kw-unsafe>? 
        <kw-mod> 
        <identifier> 
        <tok-semi>
    }

    rule module:sym<block> {
        <kw-unsafe>?
        <kw-mod>
        <identifier>
        <tok-lbrace>
        <inner-attribute>*
        <crate-item>*
        <tok-rbrace>
    }
}

our role Crate::Actions {

    method crate($/) {
        make Crate.new(
            inner-attributes => $<inner-attribute>>>.made,
            crate-item       => $<crate-item>>>.made,
        )
    }

    method as-clause($/) {
        make AsClause.new(
            identifier-or-underscore => $<identifier-or-underscore>.made,
        )
    }

    method extern-crate($/) {
        make ExternCrate.new(
            crate-ref       => $<crate-ref>.made,
            maybe-as-clause => $<as-clause>.made,
        )
    }

    method crate-ref:sym<id>($/)   { make $<identifier>.made }
    method crate-ref:sym<self>($/) { make $<kw-selfvalue>.made }

    #-------------------------
    method module:sym<semi>($/) {
        make ModuleSemi.new(
            unsafe     => so $/<kw-unsafe>:exists,
            identifier => $<identifier>.made,
        )
    }

    method module:sym<block>($/) {
        make ModuleBlock.new(
            unsafe           => so $/<kw-unsafe>:exists,
            identifier       => $<identifier>.made,
            inner-attributes => $<inner-attribute>>>.made,
            crate-item       => $<crate-item>>>.made,
        )
    }
}

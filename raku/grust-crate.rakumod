use Data::Dump::Tree;

our class Crate {
    has Bool $.bom;
    has Bool $.shebang;
    has @.inner-attributes;
    has @.crate-items;

    has $.text;

    method gist {

        my $builder = "";

        if $.bom {
            $builder ~= 0xFEFF.Str;
        }

        if $.shebang {
            $builder ~= "#!";
        }

        for @.inner-attributes {
            $builder ~= $_.gist ~ "\n";
        }

        for @.crate-items {
            $builder ~= $_.gist ~ "\n\n";
        }

        $builder
    }
}

our class AsClause {
    has $.identifier-or-underscore;

    has $.text;

    method gist {
        "as " ~ $.identifier.or-underscore.gist
    }
}

our class ExternCrate {
    has $.crate-ref;
    has $.maybe-as-clause;

    has $.text;

    method gist {

        my $builder = "extern crate ";

        $builder ~= $.crate-ref.gist;

        if $.maybe-as-clause {
            $builder ~= " " ~ $.maybe-as-clause.gist;
        }

        $builder ~ ";"
    }
}

our class ModuleSemi {
    has Bool $.unsafe;
    has $.identifier;

    has $.text;

    method gist {

        my $builder = "";

        if $.unsafe {
            $builder ~= "unsafe ";
        }

        $builder ~= "mod " ~ $.identifier.gist ~ ";";

        $builder
    }
}

our class ModuleBlock {
    has Bool $.unsafe;
    has $.identifier;
    has @.inner-attributes;
    has @.crate-items;

    has $.text;

    method gist {

        my $builder = "";

        if $.unsafe {
            $builder ~= "unsafe ";
        }

        $builder ~= "mod " ~ $.identifier.gist;

        $builder ~= "{\n";

        for @.inner-attributes {
            my $item = $_.gist ~ "\n";
            $builder ~= $item.indent(4);
        }

        for @.crate-items {
            my $item = $_.gist ~ "\n";
            $builder ~= $item.indent(4);
        }

        $builder ~= "\n}";

        $builder
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
            bom              => so $/<utf8-bom>:exists,
            shebang          => so $/<shebang>:exists,
            inner-attributes => $<inner-attribute>>>.made,
            crate-items      => $<crate-item>>>.made,
            text             => $/.Str,
        )
    }

    method as-clause($/) {
        make AsClause.new(
            identifier-or-underscore => $<identifier-or-underscore>.made,
            text                     => $/.Str,
        )
    }

    method extern-crate($/) {
        make ExternCrate.new(
            crate-ref       => $<crate-ref>.made,
            maybe-as-clause => $<as-clause>.made,
            text            => $/.Str,
        )
    }

    method crate-ref:sym<id>($/)   { make $<identifier>.made }
    method crate-ref:sym<self>($/) { make $<kw-selfvalue>.made }

    #-------------------------
    method module:sym<semi>($/) {
        make ModuleSemi.new(
            unsafe     => so $/<kw-unsafe>:exists,
            identifier => $<identifier>.made,
            text => $/.Str,
        )
    }

    method module:sym<block>($/) {
        make ModuleBlock.new(
            unsafe           => so $/<kw-unsafe>:exists,
            identifier       => $<identifier>.made,
            inner-attributes => $<inner-attribute>>>.made,
            crate-item       => $<crate-item>>>.made,
            text => $/.Str,
        )
    }
}

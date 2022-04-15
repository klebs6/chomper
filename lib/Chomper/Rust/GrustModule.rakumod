unit module Chomper::Rust::GrustModule;

use Data::Dump::Tree;

class ModuleSemi is export {
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

    method name {
        $.identifier.gist
    }

    method has-name {
        True
    }
}

class ModuleBlock is export {
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

        $builder ~= "\{\n";

        for @.inner-attributes {
            my $item = $_.gist ~ "\n";
            $builder ~= $item.indent(4);
        }

        for @.crate-items {
            my $item = $_.gist ~ "\n";
            $builder ~= $item.indent(4);
        }

        $builder ~= "\n\}";

        $builder
    }

    method name {
        $.identifier.gist
    }

    method has-name {
        True
    }
}

package ModuleGrammar is export {

    our role Rules {

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

    our role Actions {

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
}

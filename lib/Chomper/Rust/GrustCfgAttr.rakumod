unit module Chomper::Rust::GrustCfgAttr;

use Data::Dump::Tree;

class CfgAttribute is export {
    has $.configuration-predicate;

    has $.text;

    method gist {
        "cfg(" ~  $.configuration-predicate.gist ~ ")"
    }
}

class CfgAttrAttribute is export {
    has $.configuration-predicate;
    has $.maybe-cfg-attrs;

    has $.text;

    method gist {
        if $.maybe-cfg-attrs {
            "cfg_attr(" 
            ~  $.configuration-predicate.gist 
            ~ "," 
            ~ $.maybe-cfg-attrs.gist 
            ~ ")"
        } else {
            "cfg_attr(" 
            ~  $.configuration-predicate.gist 
            ~ ")"
        }
    }
}

class CfgAttrs is export {
    has @.attrs;

    has $.text;

    method gist {
        @.attrs>>.gist.join(", ")
    }
}

class InnerAttribute is export {
    has $.attr;

    has $.text;

    method gist {
        "#![" ~ $.attr.gist ~ "]"
    }
}

class OuterAttribute is export {
    has $.attr;
    has $.maybe-comment;

    has $.text;

    method gist {
        my $builder = "#[" ~ $.attr.gist ~ "]";

        if $.maybe-comment {
            $builder ~= $.maybe-comment.gist;
        }

        $builder
    }
}

class Attr is export {
    has $.simple-path;
    has $.maybe-attr-input;

    has $.text;

    method gist {
        if $.maybe-attr-input {
            $.simple-path.gist ~ $.maybe-attr-input.gist
        } else {
            $.simple-path.gist
        }
    }
}

class AttrInputEqExpr is export {
    has $.expression;

    has $.text;

    method gist {
        "= " ~ $.expression.gist
    }
}

package CfgAttrGrammar is export {

    our role Rules {

        token kw-cfg      { cfg }
        token kw-cfg-attr { cfg_attr }

        proto rule cfg-attr-attribute { * }

        rule cfg-attr-attribute:sym<cfg> {
            <kw-cfg> 
            <tok-lparen> 
            <configuration-predicate>
            <tok-rparen> 
        }

        rule cfg-attr-attribute:sym<cfg-attr> {
            <kw-cfg-attr> 
            <tok-lparen> 
            <configuration-predicate>
            <tok-comma>
            <cfg-attrs>?
            <tok-rparen> 
        }

        rule cfg-attrs {
            <attr>+ %% <tok-comma>
        }

        token tok-shebang {
            <tok-pound>
            <tok-bang>
        }

        rule inner-attribute {
            <tok-shebang>
            <tok-lbrack>
            <attr>
            <tok-rbrack>
        }

        rule outer-attribute {
            <tok-pound>
            <tok-lbrack>
            <attr>
            <tok-rbrack>
            <line-comment>?
        }

        rule attr {
            <simple-path>
            <attr-input>?
        }

        #-------------------
        proto rule attr-input { * }

        rule attr-input:sym<token-tree> {
            <delim-token-tree>
        }

        rule attr-input:sym<eq-expr> {
            <tok-eq>
            <expression>
        }
    }

    our role Actions {

        method cfg-attr-attribute:sym<cfg>($/) {
            make CfgAttribute.new(
                configuration-predicate => $<configuration-predicate>.made,
                text                    => $/.Str,
            )
        }

        method cfg-attr-attribute:sym<cfg-attr>($/) {
            make CfgAttrAttribute.new(
                configuration-predicate => $<configuration-predicate>.made,
                maybe-cfg-attrs         => $<cfg-attrs>.made,
                text                    => $/.Str,
            )
        }

        method cfg-attrs($/) {
            make $<attr>>>.made
        }

        method inner-attribute($/) {
            make InnerAttribute.new(
                attr => $<attr>.made,
                text => $/.Str,
            )
        }

        method outer-attribute($/) {
            make OuterAttribute.new(
                attr          => $<attr>.made,
                maybe-comment => $<line-comment>.made,
                text          => $/.Str,
            )
        }

        method attr($/) {
            make Attr.new(
                simple-path       => $<simple-path>.made,
                maybe-attr-input  => $<attr-input>.made,
                text              => $/.Str,
            )
        }

        #-------------------
        method attr-input:sym<token-tree>($/) {
            make $<delim-token-tree>.made
        }

        method attr-input:sym<eq-expr>($/) {
            make AttrInputEqExpr.new(
                expression => $<expression>.made,
                text       => $/.Str,
            )
        }
    }
}

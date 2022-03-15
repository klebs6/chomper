our class CfgAttribute {
    has $.configuration-predicate

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

our class CfgAttrAttribute {
    has $.configuration-predicate
    has $.maybe-cfg-attrs

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

our class CfgAttrs {
    has @.attrs;

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

our class InnerAttribute {
    has $.attr;

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

our class OuterAttribute {
    has $.attr;

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

our class Attr {
    has $.simple-path;
    has $.maybe-attr-input;

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

our class AttrInputEqExpr {
    has $.expression;

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

our role CfgAttr::Rules {

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

our role CfgAttr::Actions {

    method cfg-attr-attribute:sym<cfg>($/) {
        make CfgAttribute.new(
            configuration-predicate => $<configuration-predicate>.made
            text => $/.Str,
        )
    }

    method cfg-attr-attribute:sym<cfg-attr>($/) {
        make CfgAttrAttribute.new(
            configuration-predicate => $<configuration-predicate>.made,
            maybe-cfg-attrs         => $<cfg-attrs>.made,
            text => $/.Str,
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
            attr => $<attr>.made,
            text => $/.Str,
        )
    }

    method attr($/) {
        make Attr.new(
            simple-path => $<simple-path>.made,
            attr-input  => $<attr-input>.made,
            text => $/.Str,
        )
    }

    #-------------------
    method attr-input:sym<method-tree>($/) {
        make $<delim-token-tree>.made
    }

    method attr-input:sym<eq-expr>($/) {
        make AttrInputEqExpr.new(
            expression => $<expression>.made,
            text => $/.Str,
        )
    }
}

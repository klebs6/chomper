unit module Chomper::Rust::GrustMacros;

use Data::Dump::Tree;

our class MacroExpression is export {
    has $.simple-path;
    has $.delim-token-tree;

    has $.text;

    method gist {
        $.simple-path.gist ~ "!" ~ $.delim-token-tree.gist
    }
}

our enum DelimKind<Brack Brace Paren>;

our class DelimTokenTree is export {
    has @.token-trees;
    has DelimKind $.kind;

    has $.text;

    method gist {
        given $.kind {
            when DelimKind::<Brack> {
                "[" ~ @.token-trees>>.gist.join("") ~ "]"
            }
            when DelimKind::<Brace> {
                "\{" ~ @.token-trees>>.gist.join("") ~ "\}"
            }
            when DelimKind::<Paren> {
                "(" ~ @.token-trees>>.gist.join("") ~ ")"
            }
        }
    }
}

our class TokenTreeLeaf is export {
    has $.rust-token-no-delim;

    method gist {
        $.rust-token-no-delim
    }
}

our class TokenTree is export {
    has $.delim-token-tree;

    has $.text;

    method gist {
        $.delim-token-tree.gist
    }
}

our class MacroInvocation is export {
    has $.maybe-comment;
    has $.simple-path;
    has @.token-trees;

    has DelimKind $.delim-kind;

    has $!text;

    method maybe-item-name {
        Nil
    }

    method gist {

        my $builder = "";

        if $.maybe-comment {
            $builder ~= $.maybe-comment.gist ~ "\n";
        }

        $builder ~= $.simple-path.gist ~ '!';

        $builder ~= do given $.delim-kind {
            when DelimKind::<Paren> { "(" }
            when DelimKind::<Brack> { "[" }
            when DelimKind::<Brace> { "\{" }
        };

        $builder ~= @.token-trees>>.gist.join("\n");

        $builder ~= do given $.delim-kind {
            when DelimKind::<Paren> { ")" }
            when DelimKind::<Brack> { "]" }
            when DelimKind::<Brace> { "}" }
        };

        if $.delim-kind eq Paren or $.delim-kind eq Brack {
            $builder ~= ";";
        }

        $builder
    }
}

our class MacroRulesDefinition is export {
    has $.identifier;
    has $.macro-rules-def;

    has $.text;

    method maybe-item-name {
        $.identifier.gist
    }

    method gist {
        "macro_rules!" 
        ~ $.identifier.gist 
        ~ $.macro-rules-def.gist
    }
}

our class MacroRulesDef is export {
    has $.maybe-comment;
    has $.macro-rules;

    has $.text;

    method gist {

        my $builder = '{';

        if $.maybe-comment {
            $builder ~= $.maybe-comment.gist;
        }

        $builder ~= $.macro-rules.List>>.gist.join(";\n");

        $builder ~= '}';

        $builder
    }
}

our class MacroRule is export {

    has $.macro-matcher;
    has $.macro-transcriber;

    has $.text;

    method gist {
        $.macro-matcher.gist ~ "=>" ~ $.macro-transcriber.gist
    }
}

our class MacroMatcher is export {
    has @.macro-matches;

    has $.text;

    method gist {
        '{' ~ @.macro-matches>>.gist.join("\n") ~ '}'
    }
}

our class MacroMatchToken is export {
    has $.token;

    has $.text;

    method gist {
        $.token
    }
}

our class MacroMatchMatcher is export {
    has $.macro-matcher;

    has $.text;

    method gist {
        $.macro-matcher
    }
}

our class MacroMatchSingle is export {
    has $.identifier;
    has $.macro-frag-spec;

    has $.text;

    method gist {
        '$' ~ $.identifier.gist ~ ":" ~ $.macro-frag-spec.gist
    }
}

our class MacroMatchPlural is export {
    has @.macro-matches;
    has $.maybe-macro-rep-sep;
    has $.macro-rep-op;

    has $.text;

    method gist {

        my $builder = "";

        $builder ~= '$(';

        $builder ~= @.macro-matches>>.gist.join(" ");

        $builder ~= ')';

        if $.maybe-macro-rep-sep {
            $builder ~= $.maybe-macro-rep-sep.gist ~ " ";
        }

        $builder ~= $.macro-rep-op.gist;

        $builder
    }
}

our class MacroRepSep is export {
    has $.token;

    has $.text;

    method gist {
        $.token.gist
    }
}

our class MacroRepOpStar  is export { method gist { "*" } }
our class MacroRepOpPlus  is export { method gist { "+" } }
our class MacroRepOpQmark is export { method gist { "?" } }

our class MacroTranscriber is export {
    has $.delim-token-tree;

    has $.text;

    method gist {
        $.delim-token-tree.gist
    }
}

package MacroFragSpec is export {
    our class Block    { method gist { "block"     } } 
    our class Expr     { method gist { "expr"      } } 
    our class Ident    { method gist { "ident"     } } 
    our class Item     { method gist { "item"      } } 
    our class Lifetime { method gist { "lifetime"  } } 
    our class Literal  { method gist { "literal"   } } 
    our class Meta     { method gist { "meta"      } } 
    our class Pat      { method gist { "pat"       } } 
    our class PatParam { method gist { "pat_param" } } 
    our class Path     { method gist { "path"      } } 
    our class Stmt     { method gist { "stmt"      } } 
    our class Tt       { method gist { "tt"        } } 
    our class Ty       { method gist { "ty"        } } 
    our class Vis      { method gist { "vis"       } } 
}

package MacroInvocationGrammar is export {

    our role Rules {

        rule macro-expression {
            <simple-path> 
            <tok-bang> 
            <delim-token-tree>
        }

        proto rule delim-token-tree { * }

        rule delim-token-tree:sym<paren> {
            <tok-lparen> <token-tree>* <tok-rparen>
        }

        rule delim-token-tree:sym<brack> {
            <tok-lbrack> <token-tree>* <tok-rbrack>
        }

        rule delim-token-tree:sym<brace> {
            <tok-lbrace> <token-tree>* <tok-rbrace>
        }

        rule token-trees { <token-tree>* }

        proto rule token-tree { * }

        rule token-tree:sym<block-comment> { <block-comment> }
        rule token-tree:sym<leaf>          { <rust-token-no-delim> }
        rule token-tree:sym<tree>          { <delim-token-tree> }

        proto rule macro-invocation { * }

        rule macro-invocation:sym<paren> {
            <comment>? 
            <simple-path> 
            <.tok-bang> 
            <.tok-lparen> 
            <token-tree>* 
            <.tok-rparen> 
            <.tok-semi>
        }

        rule macro-invocation:sym<brack> {
            <comment>? 
            <simple-path> 
            <.tok-bang> 
            <.tok-lbrack> 
            <token-tree>* 
            <.tok-rbrack> 
            <.tok-semi>
        }

        rule macro-invocation:sym<brace> {
            <comment>? 
            <simple-path> 
            <.tok-bang> 
            <.tok-lbrace> 
            <token-tree>* 
            <.tok-rbrace>
        }

        token kw-macro-rules {
            macro_rules
        }

        rule macro-rules-definition {
            <kw-macro-rules> 
            <tok-bang>
            <identifier>
            <macro-rules-def>
        }

        rule macro-rules-def {
            | <tok-lparen> <comment>? <macro-rules> <tok-rparen> <tok-semi>
            | <tok-lbrack> <comment>? <macro-rules> <tok-rbrack> <tok-semi>
            | <tok-lbrace> <comment>? <macro-rules> <tok-rbrace>
        }

        rule macro-rules {
            <macro-rule>+ %% <tok-semi>
        }

        rule macro-rule {
            <macro-matcher> <tok-fat-rarrow> <macro-transcriber>
        }

        rule macro-matcher {
            | <tok-lparen> <macro-match>* <tok-rparen>
            | <tok-lbrack> <macro-match>* <tok-rbrack>
            | <tok-lbrace> <macro-match>* <tok-rbrace>
        }

        #-----------------
        proto rule macro-match { * }

        rule macro-match:sym<token>   { 
            <token-except-dollar-and-delimiters> 
        }

        rule macro-match:sym<matcher> { 
            <macro-matcher> 
        }

        rule macro-match:sym<single>  { 
            <tok-dollar> 
            <identifier> 
            <tok-colon> 
            <macro-frag-spec> 
        }

        rule macro-match:sym<plural>  { 
            <tok-dollar> 
            <tok-lparen> 
            <macro-match>+ 
            <tok-rparen> 
            <macro-rep-sep>? 
            <macro-rep-op> 
        }

        #-----------------
        proto rule macro-frag-spec { * }

        rule macro-frag-spec:sym<block>     { block }
        rule macro-frag-spec:sym<expr>      { expr }
        rule macro-frag-spec:sym<ident>     { ident }
        rule macro-frag-spec:sym<item>      { item }
        rule macro-frag-spec:sym<lifetime>  { lifetime }
        rule macro-frag-spec:sym<literal>   { literal }
        rule macro-frag-spec:sym<meta>      { meta }
        rule macro-frag-spec:sym<pat>       { pat }
        rule macro-frag-spec:sym<pat_param> { pat_param }
        rule macro-frag-spec:sym<path>      { path }
        rule macro-frag-spec:sym<stmt>      { stmt }
        rule macro-frag-spec:sym<tt>        { tt }
        rule macro-frag-spec:sym<ty>        { ty }
        rule macro-frag-spec:sym<vis>       { vis }

        rule macro-rep-sep {
            <token-except-delimiters-and-repetition-operators>
        }

        proto rule macro-rep-op { * }
        rule macro-rep-op:sym<star>  { <tok-star> }
        rule macro-rep-op:sym<plus>  { <tok-plus> }
        rule macro-rep-op:sym<qmark> { <tok-qmark> }

        rule macro-transcriber {
            <delim-token-tree>
        }
    }

    our role Actions {

        method macro-expression($/) {
            make MacroExpression.new(
                simple-path      => $<simple-path>.made,
                delim-token-tree => $<delim-token-tree>.made,
                text             => $/.Str,
            )
        }

        method delim-token-tree:sym<brack>($/) {
            make DelimTokenTree.new(
                token-trees => $<token-tree>>>.made,
                kind        => DelimKind::<Brack>,
                text        => $/.Str,
            )
        }

        method delim-token-tree:sym<brace>($/) {
            make DelimTokenTree.new(
                token-trees => $<token-tree>>>.made,
                kind        => DelimKind::<Brace>,
                text        => $/.Str,
            )
        }

        method delim-token-tree:sym<paren>($/) {
            make DelimTokenTree.new(
                token-trees => $<token-tree>>>.made,
                kind        => DelimKind::<Paren>,
                text        => $/.Str,
            )
        }

        method token-trees($/) { make $<token-tree>>>.made }

        method token-tree:sym<leaf>($/) { 
            make TokenTreeLeaf.new(
                rust-token-no-delim => ~$/,
            )
        }

        method token-tree:sym<tree>($/) { 
            make TokenTree.new(
                delim-token-tree => $<delim-token-tree>.made,
                text             => $/.Str,
            )
        }

        method macro-invocation:sym<paren>($/) {
            make MacroInvocation.new(
                maybe-comment => $<comment>.made,
                simple-path   => $<simple-path>.made,
                token-trees   => $<token-tree>>>.made,
                delim-kind    => DelimKind::<Paren>,
                text          => $/.Str,
            )
        }

        method macro-invocation:sym<brack>($/) {
            make MacroInvocation.new(
                maybe-comment => $<comment>.made,
                simple-path   => $<simple-path>.made,
                token-trees   => $<token-tree>>>.made,
                delim-kind    => DelimKind::<Brack>,
                text          => $/.Str,
            )
        }

        method macro-invocation:sym<brace>($/) {
            make MacroInvocation.new(
                maybe-comment => $<comment>.made,
                simple-path   => $<simple-path>.made,
                token-trees   => $<token-tree>>>.made,
                delim-kind    => DelimKind::<Brace>,
                text          => $/.Str,
            )
        }

        method macro-rules-definition($/) {
            make MacroRulesDefinition.new(
                identifier      => $<identifier>.made,
                macro-rules-def => $<macro-rules-def>.made,
                text            => $/.Str,
            )
        }

        method macro-rules-def($/) {
            make MacroRulesDef.new(
                maybe-comment => $<comment>.made,
                macro-rules   => $<macro-rules>.made,
                text          => $/.Str,
            )
        }

        method macro-rules($/) {
            make $<macro-rule>>>.made
        }

        method macro-rule($/) {
            make MacroRule.new(
                macro-matcher     => $<macro-matcher>.made,
                macro-transcriber => $<macro-transcriber>.made,
                text              => $/.Str,
            )
        }

        method macro-matcher($/) {
            make MacroMatcher.new(
                macro-matches => $<macro-match>>>.made,
                text          => $/.Str,
            )
        }

        #-----------------
        method macro-match:sym<token>($/)   { 
            make MacroMatchToken.new(
                token => $<token-except-dollar-and-delimiters>.made,
                text  => $/.Str,
            )
        }

        method macro-match:sym<matcher>($/) { 
            make MacroMatchMatcher.new(
                macro-matcher => $<macro-matcher>.made,
                text          => $/.Str,
            )
        }

        method macro-match:sym<single>($/)  { 
            make MacroMatchSingle.new(
                identifier      => $<identifier>.made,
                macro-frag-spec => $<macro-frag-spec>.made,
                text            => $/.Str,
            )
        }

        method macro-match:sym<plural>($/)  { 
            make MacroMatchPlural.new(
                macro-matches       => $<macro-match>>>.made,
                maybe-macro-rep-sep => $<macro-rep-sep>.made,
                macro-rep-op        => $<macro-rep-op>.made,
                text                => $/.Str,
            )
        }

        #-----------------
        method macro-frag-spec:sym<block>($/)     { make MacroFragSpec::Block.new }
        method macro-frag-spec:sym<expr>($/)      { make MacroFragSpec::Expr.new }
        method macro-frag-spec:sym<ident>($/)     { make MacroFragSpec::Ident.new }
        method macro-frag-spec:sym<item>($/)      { make MacroFragSpec::Item.new }
        method macro-frag-spec:sym<lifetime>($/)  { make MacroFragSpec::Lifetime.new }
        method macro-frag-spec:sym<literal>($/)   { make MacroFragSpec::Literal.new }
        method macro-frag-spec:sym<meta>($/)      { make MacroFragSpec::Meta.new }
        method macro-frag-spec:sym<pat>($/)       { make MacroFragSpec::Pat.new }
        method macro-frag-spec:sym<pat_param>($/) { make MacroFragSpec::PatParam.new }
        method macro-frag-spec:sym<path>($/)      { make MacroFragSpec::Path.new }
        method macro-frag-spec:sym<stmt>($/)      { make MacroFragSpec::Stmt.new }
        method macro-frag-spec:sym<tt>($/)        { make MacroFragSpec::Tt.new }
        method macro-frag-spec:sym<ty>($/)        { make MacroFragSpec::Ty.new }
        method macro-frag-spec:sym<vis>($/)       { make MacroFragSpec::Vis.new }

        method macro-rep-sep($/) {
            make MacroRepSep.new(
                token => $<token-except-delimiters-and-repetition-operators>.made,
                text  => $/.Str,
            )
        }

        method macro-rep-op:sym<star>($/)  { make MacroRepOpStar.new }
        method macro-rep-op:sym<plus>($/)  { make MacroRepOpPlus.new }
        method macro-rep-op:sym<qmark>($/) { make MacroRepOpQmark.new }

        method macro-transcriber($/) {
            make MacroTranscriber.new(
                delim-token-tree => $<delim-token-tree>.made,
                text             => $/.Str,
            )
        }
    }
}
